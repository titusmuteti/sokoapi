class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :total_price, :unit_price
  
  belongs_to :product
  belongs_to :order
end
