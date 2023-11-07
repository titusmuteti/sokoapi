class OrdersController < ApplicationController
  def index
    orders = Order.all
    render json: orders, status: :ok
  end

  def show
    order = Order.find(params[:id])
    render json: order, status: :ok
  end

  def edit
    order = Order.find(params[:id])
  end

  def create
    order = Order.new(order_params)

    if order.save
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def update
    order = Order.find(params[:id])

    if order.update(order_params)
      render json: order, status: :ok
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    
    render json: { message: 'order deleted successfully' }, status: :o
  end

  private

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:quantity, :total_price, :order_status, :order_date, :address_id, :user_id, :product_id)
    end
    
end
