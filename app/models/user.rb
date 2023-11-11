class User < ApplicationRecord
    has_secure_password
  
    has_many :addresses
    has_many :orders
  
    accepts_nested_attributes_for :addresses
  
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
  
    def add_product_to_cart(product_id)
      order = orders.find_or_create_by(order_status: 'cart')
      product = Product.find(product_id)
  
      if order.add_product(product)
        order
      else
        errors.add(:base, 'Failed to add product to cart')
        nil
      end
    end
end
  