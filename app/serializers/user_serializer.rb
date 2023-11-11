class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :password, :email

  has_many :addresses
  has_many :orders
end
