class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def update_quantity(new_quantity = quantity)
    update(quantity: new_quantity.to_i)
  end
end
