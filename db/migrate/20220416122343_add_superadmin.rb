class AddSuperadmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins,:superuser,:boolean
  end
end
