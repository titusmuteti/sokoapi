class AddressSerializer < ActiveModel::Serializer
  attributes :id

  has_many :orders
  belongs_to :user
end
