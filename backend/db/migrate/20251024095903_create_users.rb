class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :encrypted_password
      t.string :tax_id

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :tax_id
  end
end
