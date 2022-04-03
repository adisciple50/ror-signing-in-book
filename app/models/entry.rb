class Entry < ApplicationRecord
  # attr_accessor :name,:time_in,:time_out,:mobile_number
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :time_in,presence: true
  validates :name,presence: true
  # after_save_commit -> { broadcast_prepend_to "entries", partial: "entries/entry", locals: { quote: self }, target: "entries" }
  # after_destroy_commit -> { broadcast_destroy_to "entries", partial: "entries/entry", locals: { quote: self }, target: "entries" }
  broadcasts_to -> (entry){:entries} #https://blog.corsego.com/turbo-hotwire-broadcasts
  # entries is the name of the parameter passed to turbo stream from parameter in index.html.erb
  # in this case it is entries. entry is the name of the partial of which the broadcast will pass to the stream
end
