class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def update_quantity(new_quantity)
    new_quantity = new_quantity.to_i

    if new_quantity >= 1
      update(quantity: new_quantity)
      true
    else
      false
    end
  end
end
