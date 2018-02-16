class User < ApplicationRecord
  include BCrypt
  has_many :plants
  has_secure_password
  validates :email, uniqueness: true, presence: true
end
