class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_details

  def add_product(product)  
    existing_order_item = order_items.find_by(product_id: product.id)

    if existing_order_item
      existing_order_item.quantity += 1
    else
      existing_order_item = order_items.build(product: product, quantity: 1, total_price: product.price)
    end

    save
  end
end
