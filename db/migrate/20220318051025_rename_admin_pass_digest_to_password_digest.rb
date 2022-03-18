class RenameAdminPassDigestToPasswordDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :admins,:pass_digest,:password_digest
  end
end
