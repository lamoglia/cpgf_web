# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160516173640) do

  create_table "favored", force: true do |t|
    t.string   "name"
    t.string   "masked_document"
    t.string   "url"
    t.decimal  "total_transactions", precision: 12, scale: 2
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_image"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "management_units", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "masked_document"
    t.decimal  "total_transactions", precision: 12, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "sources", force: true do |t|
    t.string   "file_name"
    t.date     "reference"
    t.datetime "imported_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subordinated_organs", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "superior_organs", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspect_reports", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suspect_reports", ["transaction_id"], name: "index_suspect_reports_on_transaction_id", using: :btree

  create_table "transaction_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "friendly_description"
  end

  create_table "transactions", force: true do |t|
    t.decimal  "value",                 precision: 10, scale: 2,                 null: false
    t.date     "date"
    t.boolean  "hidden_date",                                    default: false
    t.integer  "superior_organ_id"
    t.integer  "subordinated_organ_id"
    t.integer  "management_unit_id"
    t.integer  "source_id"
    t.integer  "person_id"
    t.integer  "favored_id"
    t.integer  "transaction_type_id"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "transactions", ["date"], name: "index_transactions_on_date", using: :btree
  add_index "transactions", ["favored_id"], name: "index_transactions_on_favored_id", using: :btree
  add_index "transactions", ["management_unit_id"], name: "index_transactions_on_management_unit_id", using: :btree
  add_index "transactions", ["person_id"], name: "index_transactions_on_person_id", using: :btree
  add_index "transactions", ["source_id"], name: "index_transactions_on_source_id", using: :btree
  add_index "transactions", ["subordinated_organ_id"], name: "index_transactions_on_subordinated_organ_id", using: :btree
  add_index "transactions", ["superior_organ_id"], name: "index_transactions_on_superior_organ_id", using: :btree
  add_index "transactions", ["transaction_type_id"], name: "index_transactions_on_transaction_type_id", using: :btree

end
