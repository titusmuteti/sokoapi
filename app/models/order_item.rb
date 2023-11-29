class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def user
    order.user
  end
end
