class User < ApplicationRecord
    has_secure_password
  
    has_many :addresses
    has_many :orders
  
    accepts_nested_attributes_for :addresses
  
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    def generate_jwt
        JWT.encode({ user_id: id }, 'your_secret_key', 'HS256')
    end

    def self.decode_jwt(token)
        JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')[0]
    end
end
  