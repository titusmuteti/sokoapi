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

  def add_to_cart
    order = current_user.orders.find_or_create_by(order_status: 'cart')

    product = Product.find(params[:product_id])
    order_item = order.order_items.find_or_initialize_by(product: product)

    if order_item.new_record?
      order_item.quantity = 1
      order_item.price = product.price
    else
      order_item.quantity += 1
    end

    if order_item.save
      render json: order, status: :created
    else
      render json: order_item.errors, status: :unprocessable_entity
    end
  end

  def reduce_quantity
    order_item = OrderItem.find(params[:order_item_id])

    if order_item.quantity > 1
      order_item.quantity -= 1
      if order_item.save
        render json: order_item.order, status: :ok
      else
        render json: order_item.errors, status: :unprocessable_entity
      end
    else
      destroy_order_item(order_item)
    end
  end

  def remove_from_cart
    order_item = OrderItem.find(params[:order_item_id])
    destroy_order_item(order_item)
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
