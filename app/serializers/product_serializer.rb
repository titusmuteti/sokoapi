class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description, :category, :image, :rating

  has_many :orders
  has_many :users, through: :orders
end
