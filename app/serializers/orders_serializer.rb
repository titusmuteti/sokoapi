class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :total_price, :order_status, :order_date, :user_id, :product_id

  belongs_to :address
end
