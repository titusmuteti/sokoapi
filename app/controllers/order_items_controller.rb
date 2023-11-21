# app/controllers/order_items_controller.rb
class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all
  end

  def show
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      redirect_to @order_item, notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @order_item = OrderItem.find(params[:id])

    # Get the current quantity and unit price from the order item
    current_quantity = @order_item.quantity
    unit_price = @order_item.unit_price

    if params[:increase_quantity]
      @order_item.quantity += 1
    elsif params[:decrease_quantity] && current_quantity > 1
      @order_item.quantity -= 1
    end

    # Update the total price based on the new quantity
    @order_item.total_price = @order_item.quantity * unit_price

    if @order_item.save
      redirect_to @order_item, notice: 'Order item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @order_item.destroy
    redirect_to order_items_url, notice: 'Order item was successfully destroyed.'
  end

  private
  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :quantity, :total_price, :unit_price)
  end
end
