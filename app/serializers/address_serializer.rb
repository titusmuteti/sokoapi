class AddressSerializer < ActiveModel::Serializer
  attributes :id, :city, :region

  belongs_to :user
  has_many :orders
end
