class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: [:show, :update]

  def index
    orders = Order.all
    render json: orders, status: :ok
  end

  def show
    order = Order.find(params[:id])
    render json: order, status: :ok
  end

  def create
    puts "Entering create method" 
    puts "Session in OrdersController: #{session.inspect}"
    require_login
  
    product = Product.find(params[:product_id])
    order = current_user.orders.find_or_create_by(order_status: 'cart')
  
    if order.add_product(product)
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end  

  def update
    if @order.owned_by?(current_user) && @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: { error: 'Unauthorized or invalid order' }, status: :unauthorized
    end
  end

  private
  def set_order
    @order = current_user.orders.find_by(id: params[:id])
  
    unless @order
      render json: { error: 'Order not found' }, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :address_id, :order_date, :order_status, :payment_status, :total_amount)
  end
  
end
