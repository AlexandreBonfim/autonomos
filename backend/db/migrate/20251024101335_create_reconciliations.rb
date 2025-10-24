class CreateReconciliations < ActiveRecord::Migration[8.0]
  def change
    create_table :reconciliations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bank_txn, null: false, foreign_key: true
      t.references :matchable, polymorphic: true, null: false # Expense or Invoice
      t.decimal :matched_amount, precision: 12, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
