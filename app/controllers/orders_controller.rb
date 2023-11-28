class OrdersController < ApplicationController
  before_action :require_login, only: [:create, :update]
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
    product = Product.find(params[:product_id])
    address_id = params[:address_id]  # Include address_id

    # Build order_params with order_status and optional address_id
    order_params = { order_status: 'cart' }
    order_params[:address_id] = address_id if address_id.present?

    order = current_user.orders.find_or_create_by(order_params)

    # Check if the product already exists in the order
    unless order.products.include?(product)
      order.add_product(product)
      order.save
    end

    render json: order, status: :created
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    if @order.owned_by?(current_user) && @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: { error: 'Unauthorized or invalid order' }, status: :unauthorized
    end
  end

  def destroy
    if @order.owned_by?(current_user)
      @order.destroy
      render json: { message: 'Order successfully deleted' }, status: :ok
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
