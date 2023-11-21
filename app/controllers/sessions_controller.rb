class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      jwt = user.generate_jwt
      render json: { user: user, token: jwt }, status: :created
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
end
