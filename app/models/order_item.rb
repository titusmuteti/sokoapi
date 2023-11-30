class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def update_quantity(change_type = :default)
    case change_type.to_sym
    when :increase
      update(quantity: quantity + 1)
    when :decrease
      update(quantity: [quantity - 1, 0].max) # Ensure quantity doesn't go below 0
    else
      false
    end
  end  
end
