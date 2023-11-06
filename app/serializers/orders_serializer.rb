class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :total_price, :order_status, :order_date, :address_id, :user_id, :product_id

  belongs_to :address
  belongs_to :user
  belongs_to :product
end
