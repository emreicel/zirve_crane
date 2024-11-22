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

ActiveRecord::Schema[7.2].define(version: 2024_11_22_162253) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "crane_id"
    t.integer "rent_term"
    t.integer "rent_amount"
    t.date "contract_date"
    t.date "rent_start_date"
    t.date "rent_finish_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vat_percentage"
    t.string "contract_number"
    t.index ["contract_number"], name: "index_contracts_on_contract_number", unique: true
  end

  create_table "crane_owners", force: :cascade do |t|
    t.string "crane_owner_name"
    t.text "crane_owner_address"
    t.string "crane_owner_phone"
    t.string "crane_owner_vat_office"
    t.string "crane_owner_contact"
    t.string "crane_owner_contact_email"
    t.string "crane_owner_contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cranes", force: :cascade do |t|
    t.string "crane_brand_name"
    t.string "crane_model_name"
    t.string "crane_chassis_no"
    t.integer "crane_boom_length"
    t.integer "crane_height"
    t.integer "crane_tonnage"
    t.integer "crane_boom_tonnage"
    t.integer "crane_year"
    t.string "crane_company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true
    t.integer "crane_owner_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_name"
    t.string "vat_office_name"
    t.text "customer_address"
    t.string "customer_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_tables", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.integer "rent_table_quantity"
    t.date "start_date"
    t.date "end_date"
    t.decimal "amount_excluding_vat"
    t.decimal "vat_percentage"
    t.decimal "amount_including_vat"
    t.date "payment_date"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method_id"
    t.text "note"
    t.datetime "email_sent_at"
    t.index ["contract_id"], name: "index_payment_tables_on_contract_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payment_tables", "contracts"
end
