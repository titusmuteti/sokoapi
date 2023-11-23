# app/controllers/order_items_controller.rb
class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_item = OrderItem.find(params[:id])
    render json: @order_item
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      redirect_to @order_item, notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def update
    Rails.logger.info("Updating order item: #{params[:id]}")
    @order_item = OrderItem.find(params[:id])
    order_item_params = params.permit(:quantity)
  
    if params[:increase_quantity]
      order_item_params[:quantity] = (@order_item.quantity || 0) + 1
    elsif params[:decrease_quantity] && @order_item.quantity.to_i > 1
      order_item_params[:quantity] = @order_item.quantity - 1
    end    
  
    if @order_item.update(order_item_params)
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
