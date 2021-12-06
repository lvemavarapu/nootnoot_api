class UsersController < ApplicationController

  def create
      @user = User.create(user_params)
      @user.isAdmin = false
      if @user.save
          auth_token = Knock::AuthToken.new payload: {sub: @user.id}
          render json: {username: @user.username, jwt: auth_token.token}, status: 201
      else
          #puts @user.errors
          render json: @user.errors, status: :unprocessable_entity
      end
  end

  def sign_in
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
          auth_token = Knock::AuthToken.new payload: {sub: @user.id}
          render json: {username: @user.username, jwt: auth_token.token, isAdmin: @user.isAdmin}, status: 201
      else
          render json: {error: "username or password incorrect"}
      end
  end

  def user_params
      params.permit(:username, :email, :password, :password_confirmation)
  end
end