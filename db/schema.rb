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

ActiveRecord::Schema.define(version: 2019_05_23_014750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "business_items", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "item_id"
    t.float "price_sold"
    t.integer "quantity"
    t.float "serving_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_items_on_business_id"
    t.index ["item_id"], name: "index_business_items_on_item_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.bigint "distributor_id"
    t.string "name"
    t.text "address"
    t.citext "email"
    t.string "password_digest"
    t.text "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "representative_id"
    t.bigint "phone_number"
    t.index ["distributor_id"], name: "index_businesses_on_distributor_id"
    t.index ["representative_id"], name: "index_businesses_on_representative_id"
  end

  create_table "distributors", force: :cascade do |t|
    t.text "address"
    t.citext "name"
    t.text "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.citext "code"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "distributor_id"
    t.citext "name"
    t.string "alc_type"
    t.string "alc_category"
    t.float "price"
    t.float "ounces"
    t.string "unit"
    t.string "thumbnail"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["distributor_id"], name: "index_items_on_distributor_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "item_id"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "business_id"
    t.float "total_cost"
    t.float "total_revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_orders_on_business_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "name"
    t.citext "email"
    t.bigint "distributor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "phone_number"
    t.index ["distributor_id"], name: "index_representatives_on_distributor_id"
  end

  add_foreign_key "business_items", "businesses"
  add_foreign_key "business_items", "items"
  add_foreign_key "businesses", "distributors"
  add_foreign_key "businesses", "representatives"
  add_foreign_key "items", "distributors"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "businesses"
  add_foreign_key "representatives", "distributors"
end
