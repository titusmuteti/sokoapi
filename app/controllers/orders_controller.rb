class OrdersController < ApplicationController
  # before_action :authenticate_user, only: [:create, :update]

  def index
    orders = Order.all
    render json: orders, status: :ok
  end

  def show
    order = Order.find(params[:id])
    render json: order, status: :ok
  end

  def create
    product = Product.find(params[:product_id])
    order = current_user.orders.find_or_create_by(order_status: 'cart')

    order_item = order.order_items.build(
      product: product,
      quantity: 1,
      unit_price: product.price,
      total_price: product.price
    )

    if order_item.save
      render json: { message: 'Product added to cart successfully', order: order }, status: :created
    else
      render json: { errors: order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :address_id, :order_date, :order_status, :payment_status, :total_amount)
  end
end
