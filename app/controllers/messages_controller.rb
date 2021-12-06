class MessagesController < ApplicationController
    before_action :authenticate_user, except: [:index, :show] 
    before_action :find_message, only: [:show, :update, :destroy]
    before_action :check_ownership, only: [:destroy, :update] 

    def index
        @messages = []
        if (params[:username])
            Message.find_by_user(params[:username]).order('updated_at DESC').each do |msg|
                @messages << Message.find_by(id: msg.id).transform_message
            end
        else
            Message.order('updated_at DESC').each do |msg|
                @messages << Message.find_by(id: msg.id).transform_message
            end
        end
        render json: @messages
    end

    def create
        #@message = Message.create(message_params)
        @message = current_user.messages.create(message_params)
        if @message.errors.any?
            render json: @message.errors, status: :unprocessable_entity
        else
            render json: @message.transform_message, status: 201
        end
    end

    def update
        @message.update(message_params)
        if @message.errors.any?
            render json: @message.errors, status: :unprocessable_entity
        else
            render json: @message.transform_message, status: 201
        end
    end

    def show
        render json: @message.transform_message
    end

    def destroy
        @message.delete
        render json: {message: "Message deleted"}, status: 204
    end

    def my_messages
        @messages = []
        Message.find_by_user(current_user.username).order('updated_at DESC').each do |msg|
            @messages << Message.find_by(id: msg.id).transform_message
        end
        render json: @messages
    end

    def find_message
        begin
            @message = Message.find(params[:id])
        rescue
            render json: {error: "message does not exist"}, status: 404
        end
    end

    def check_ownership
        if !current_user.isAdmin
            if current_user.id != @message.user.id
                render json: {error: "unauthorized action"}
            end
        end
    end
    private
    def message_params
        params.require(:message).permit(:m_text)
    end
end