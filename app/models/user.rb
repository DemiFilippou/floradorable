class User < ApplicationRecord
  include BCrypt
  has_many :user_plants
  has_secure_password
  validates :email, uniqueness: true, presence: true
end
