class AddUsernameToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries,'username',:string
  end
end
