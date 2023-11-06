class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :address, :region, :city

  has_many :addresses
  has_many :orders
  has_many :products, through: :orders
end
