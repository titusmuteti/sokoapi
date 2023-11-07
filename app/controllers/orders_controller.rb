class OrdersController < ApplicationController
  def index
    orders = Order.all
    render json: orders
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
  end

  private

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:quantity, :total_price, :order_status, :order_date, :address_id, :user_id, :product_id)
    end
    
end
