class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items

  def add_product(product)
    order_item = order_items.build(product: product, quantity: 1, unit_price: product.price)
    order_item.save
  end
end
