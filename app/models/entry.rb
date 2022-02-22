class Entry < ApplicationRecord
  attr_accessor :name,:time_in,:time_out,:mobile_number

  validates_presence_of :time_in,:name
end
