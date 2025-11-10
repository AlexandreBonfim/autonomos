class CreateInvoiceSequences < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_sequences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :series
      t.integer :year
      t.integer :last_number, null: false, default: 0

      t.timestamps
    end
    add_index :invoice_sequences, [:user_id, :series, :year], unique: true
    add_index :invoices, [:user_id, :series, :number, :issued_on], name: "idx_invoices_unique_per_series", unique: true
  end
end
