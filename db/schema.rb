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

ActiveRecord::Schema.define(version: 20160308212845) do

  create_table "favored", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "masked_document", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "management_units", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "masked_document", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string   "file_name",   limit: 255
    t.date     "reference"
    t.datetime "imported_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "subordinated_organs", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "superior_organs", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal  "value",                           precision: 10
    t.date     "date"
    t.integer  "superior_organ_id",     limit: 4
    t.integer  "subordinated_organ_id", limit: 4
    t.integer  "management_unit_id",    limit: 4
    t.integer  "source_id",             limit: 4
    t.integer  "person_id",             limit: 4
    t.integer  "favored_id",            limit: 4
    t.integer  "transaction_type_id",   limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "transactions", ["favored_id"], name: "index_transactions_on_favored_id", using: :btree
  add_index "transactions", ["management_unit_id"], name: "index_transactions_on_management_unit_id", using: :btree
  add_index "transactions", ["person_id"], name: "index_transactions_on_person_id", using: :btree
  add_index "transactions", ["source_id"], name: "index_transactions_on_source_id", using: :btree
  add_index "transactions", ["subordinated_organ_id"], name: "index_transactions_on_subordinated_organ_id", using: :btree
  add_index "transactions", ["superior_organ_id"], name: "index_transactions_on_superior_organ_id", using: :btree
  add_index "transactions", ["transaction_type_id"], name: "index_transactions_on_transaction_type_id", using: :btree

end
