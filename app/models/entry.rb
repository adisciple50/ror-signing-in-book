class Entry < ApplicationRecord
  validates :time_in,:name,presence: true
end
