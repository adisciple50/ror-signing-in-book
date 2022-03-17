class AdminAddRecovery < ActiveRecord::Migration[7.0]
  def change
    add_column :admins,:recovery_pass,:string
  end
end
