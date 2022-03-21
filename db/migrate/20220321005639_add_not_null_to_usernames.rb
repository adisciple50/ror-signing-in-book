class AddNotNullToUsernames < ActiveRecord::Migration[7.0]
  def change
    change_column :admins,:username,:text,null: false
  end
end
