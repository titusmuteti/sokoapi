class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true
  has_many :order_items, dependent: :destroy 

  validates :order_status, inclusion: { in: %w(cart processing completed) }

  serialize :order_item_ids, Array

  def add_product(product)
    transaction do
      save! unless persisted?
      order_items.create!(product: product)
      self.order_item_ids << order_item.id
    end
  rescue ActiveRecord::RecordInvalid
    errors.add(:base, 'Failed to add product to the order')
    false
  end
   

  def owned_by?(user)
    self.user == user
  end
end
