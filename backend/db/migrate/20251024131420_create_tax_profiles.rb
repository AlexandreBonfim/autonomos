class CreateTaxProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :tax_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :default_iva_rate, precision: 5, scale: 2
      t.decimal :default_irpf_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
