class AddLoginToken < ActiveRecord::Migration[7.0]
  def change
    add_column :admins,:token,:string
  end
end
