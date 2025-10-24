class CreateBankTxns < ActiveRecord::Migration[8.0]
  def change
    create_table :bank_txns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :external_id
      t.date :occurred_on
      t.integer :amount_cents
      t.string :currency
      t.string :description
      t.jsonb :raw_payload
      t.string :source
      t.string :status

      t.timestamps
    end
    add_index :bank_txns, :external_id
  end
end
