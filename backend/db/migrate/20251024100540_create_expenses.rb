class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.integer :total_cents
      t.string :currency
      t.decimal :iva_rate, precision: 5, scale: 2
      t.integer :iva_amount_cents
      t.decimal :irpf_rate, precision: 5, scale: 2
      t.integer :irpf_withheld_cents
      t.decimal :deductible_percent, precision: 5, scale: 2
      t.date :issued_on
      t.string :supplier_name
      t.string :supplier_tax_id
      t.integer :document_id
      t.string :category
      t.string :status

      t.timestamps
    end

    add_index :expenses, :document_id
  end
end
