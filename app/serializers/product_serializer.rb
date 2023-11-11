class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description, :category, :image, :rating

  has_many :order_items
end
