class User < ApplicationRecord
    has_secure_password

    has_many :addresses
    has_many :orders
    has_many :products, through: :orders

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
