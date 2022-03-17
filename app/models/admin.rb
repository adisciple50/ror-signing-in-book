class Admin < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  has_secure_password :recovery_password, validations: false

  attr_accessor :pass_digest, :recovery_pass_digest
end
