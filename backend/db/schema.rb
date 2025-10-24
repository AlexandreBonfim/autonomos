# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_24_100829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "email"
    t.string "tax_id"
    t.text "billing_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "kind"
    t.string "status"
    t.string "original_filename"
    t.string "content_type"
    t.integer "size_bytes"
    t.string "storage_key"
    t.jsonb "metadata"
    t.jsonb "parsed_payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "description"
    t.integer "total_cents"
    t.string "currency"
    t.decimal "iva_rate", precision: 5, scale: 2
    t.integer "iva_amount_cents"
    t.decimal "irpf_rate", precision: 5, scale: 2
    t.integer "irpf_withheld_cents"
    t.decimal "deductible_percent", precision: 5, scale: 2
    t.date "issued_on"
    t.string "supplier_name"
    t.string "supplier_tax_id"
    t.integer "document_id"
    t.string "category"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_expenses_on_document_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "encrypted_password"
    t.string "tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["tax_id"], name: "index_users_on_tax_id"
  end

  add_foreign_key "clients", "users"
  add_foreign_key "documents", "users"
  add_foreign_key "expenses", "users"
end
