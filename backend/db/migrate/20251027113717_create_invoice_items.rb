class CreateInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :description
      t.integer :quantity
      t.integer :unit_price_cents
      t.integer :discount_cents
      t.decimal :iva_rate, precision: 5, scale: 2
      t.decimal :irpf_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
