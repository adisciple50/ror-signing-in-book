class Admin < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true
  validates :password_digest, presence: true, :on => :save
  # attr_accessor :password_digest # gotcha you pesky bug!
end
