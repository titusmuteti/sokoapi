class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: user, status: :ok
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
      orders.each do |order|
        order.update(user_id: nil)
      end
    end

    @user.destroy
    render json: { message: "Client deleted" }, status: :ok
  end

  private
  def record_invalid
    render json: {error: "Invalid user"}, status: :unprocessable_entity
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)
  end
end
