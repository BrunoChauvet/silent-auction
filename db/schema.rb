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

ActiveRecord::Schema.define(version: 20130921000221) do

  create_table "bids", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.decimal  "price"
    t.datetime "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id"
  add_index "bids", ["timestamp"], name: "index_bids_on_timestamp"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "categories", force: true do |t|
    t.string "name"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true

  create_table "items", force: true do |t|
    t.integer "category_id"
    t.string  "name"
    t.string  "description"
    t.string  "by"
    t.string  "code"
    t.string  "image"
    t.string  "sponsor"
    t.decimal "start_price"
  end

  add_index "items", ["code"], name: "index_items_on_code", unique: true

  create_table "preferences", force: true do |t|
    t.string "name"
    t.string "value"
  end

  add_index "preferences", ["name"], name: "index_preferences_on_name", unique: true

  create_table "user_groups", force: true do |t|
    t.string  "name"
    t.integer "sort_order"
  end

  add_index "user_groups", ["name"], name: "index_user_groups_on_name", unique: true

  create_table "users", force: true do |t|
    t.integer "user_group_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "title"
    t.string  "pin"
    t.boolean "admin",         default: false
  end

end
