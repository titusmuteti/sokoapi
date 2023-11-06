class User < ApplicationRecord
    has_many :addresses
    has_many :orders
    has_many :products, through: :orders
end
