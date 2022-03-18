class Admin < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  attr_accessor :password_digest
end
