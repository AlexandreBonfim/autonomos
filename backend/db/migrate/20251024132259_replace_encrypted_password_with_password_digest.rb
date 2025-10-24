class ReplaceEncryptedPasswordWithPasswordDigest < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :encrypted_password, :string, if_exists: true
  end
end
