class RenamePasswordSaltToPasswordDigestOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :password_salt, :password_digest
  end
end
