class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :number
      t.string :series
      t.date :issued_on
      t.date :due_on
      t.string :currency
      t.integer :subtotal_cents
      t.decimal :iva_rate, precision: 5, scale: 2
      t.integer :iva_amount_cents
      t.decimal :irpf_rate, precision: 5, scale: 2
      t.integer :irpf_withheld_cents
      t.integer :total_cents
      t.string :status
      t.text :notes

      t.timestamps
    end

    add_index :invoices, :number
  end
end
