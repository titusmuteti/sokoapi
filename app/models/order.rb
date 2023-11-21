class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items

  validates :order_status, inclusion: { in: %w(cart processing completed) }

  def add_product(product)
    order_item = order_items.build(product: product)
    
    if order_item.save
      true
    else
      errors.add(:base, 'Failed to add product to the order')
      false
    end
  end

  def owned_by?(user)
    self.user == user
  end
end
