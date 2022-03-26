class Entry < ApplicationRecord
  # attr_accessor :name,:time_in,:time_out,:mobile_number
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :time_in,presence: true
  validates :name,presence: true
end
