class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def add_product(product)
    order_item = order_items.find_or_initialize_by(product_id: product.id)

    if order_item.new_record?
      order_item.quantity = 1
      order_item.total_price = product.price
    else
      order_item.quantity += 1
      order_item.total_price += product.price
    end

    order_item.save
  end
end
