class Admin < ApplicationRecord
  include ActiveModel::SecurePassword
  validates :password_digest, presence: true, :on => :save
  validates :username, uniqueness: true
  has_secure_password
  attr_accessor :password_digest
end
