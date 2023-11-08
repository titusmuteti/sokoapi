class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    if session[:user_id]
      session.delete(:user_id)
      head :no_content
    else
      render json: { error: "You must be logged in" }, status: :unauthorized
    end
  end

  def check_user
    email = params[:email]
    user_exists = User.find_by(email: email)

    if user_exists
      render json: { message: 'User exists' }, status: :ok
    else
      render json: { message: 'User does not exist' }, status: :not_found
    end
  end
end
