class ChangePassToPassDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :admins,:pass,:pass_digest
  end
end
