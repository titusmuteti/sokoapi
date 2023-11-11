class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :total_price, :order_status, :order_date, :user_id, :product_id

  belongs_to :user
  belongs_to :address
  has_many :order_items
end
