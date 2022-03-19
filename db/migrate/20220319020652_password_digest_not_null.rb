class PasswordDigestNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column :admins,:password_digest,:text,null: false
  end
end
