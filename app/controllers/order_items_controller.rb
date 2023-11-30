class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_item = OrderItem.find(params[:id])
    render json: @order_item
  end

  def create
    # Associate the order item with a specific order
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new(order_item_params)

    if @order_item.save
      redirect_to @order, notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])

    if params[:increase_quantity]
      handle_quantity_update(1)
    elsif params[:decrease_quantity]
      handle_quantity_update(-1)
    else
      render json: { error: 'Invalid update request' }, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
  
    if @order_item.destroy
      render json: { message: 'Order item successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete order item' }, status: :unprocessable_entity
    end
  end

  private
  
  def handle_quantity_update(amount)
    if @order_item.update_quantity(@order_item.quantity + amount)
      render json: @order_item, status: :ok
    else
      render json: { error: 'Failed to update order item quantity' }, status: :unprocessable_entity
    end
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :quantity, :total_price, :unit_price)
  end
end
