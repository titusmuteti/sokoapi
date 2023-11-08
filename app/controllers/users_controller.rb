class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    if logged_in?
      render json: @current_user, status: :ok
    else
      render json: { error: "You must be logged in to access this content" }, status: :unauthorized
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    orders = Order.where(user_id: user.id)

    if orders.any?
      orders.each(&:destroy)
    end

    user.destroy # To delete the user

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number, :address, :region, :city)
  end
end
