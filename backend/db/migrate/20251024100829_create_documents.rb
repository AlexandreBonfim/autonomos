class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :kind
      t.string :status
      t.string :original_filename
      t.string :content_type
      t.integer :size_bytes
      t.string :storage_key
      t.jsonb :metadata
      t.jsonb :parsed_payload

      t.timestamps
    end
  end
end
