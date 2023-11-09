class AddressSerializer < ActiveModel::Serializer
  attributes :id, :city, :region

  has_many :orders
  belongs_to :user
end
