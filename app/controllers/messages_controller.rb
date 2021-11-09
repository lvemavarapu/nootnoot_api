class MessagesController < ApplicationController
    before_action:find_message ,only: [:show, :update, :destroy]
    before_action:authenticate_user, except: [:index, :show]
    before_action:check_ownership, only: [:destroy, :update]

    def index
        # @messages = Message.all
        @messages = Message.order('updated_at DESC')
        render json: @messages
    end
    def create
        #@message = Message.create(message_params)
        @message=current_user.messages.create(message_params)
        if @message.errors.any? 
            render.json:@message.errors, status: :unprocessable_entity
        else
            render json:@message, status: 200
    end
end
def check_ownership
    if current_user.id != @message.user.id
        render json:{error:"not authorized to delete the message"}

    end

end
def update

    # @message = Message.update(message_params)
    @message.update(message_params)

        if @message.errors.any? 
            render.json:@message.errors, status: :unprocessable_entity
        else
            render json:@message, status: 200
    end
end
def show
    render json:@message
end
   def destroy
    @message.delete
    render json:{message:"message deleted!"}, status:204
   end
   
    def find_message
        begin
        @message = Message.find(params[:id])
        rescue 
            render json:{error: "message not found"}, status: 404
    end
end
        private
    def message_params
        params.require(:message).permit(:m_text)
    end
end
