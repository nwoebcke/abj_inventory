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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140210055838) do

  create_table "customer_product_lines", :force => true do |t|
    t.integer  "customer_id",                   :null => false
    t.integer  "product_line_id",               :null => false
    t.string   "name",            :limit => 25, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "customer_product_lines", ["customer_id", "product_line_id"], :name => "index_customer_product_lines_on_customer_id_and_product_line_id"

  create_table "customers", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.string   "address",    :limit => 40
    t.string   "city",       :limit => 40
    t.string   "state",      :limit => 40
    t.string   "zip",        :limit => 20
    t.string   "phone",      :limit => 40
    t.string   "email",      :limit => 40
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "old_id",                   :null => false
    t.string   "fax",        :limit => 40
  end

  add_index "customers", ["name"], :name => "index_customers_on_name"

  create_table "garages", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "held_parts", :force => true do |t|
    t.integer  "quantity"
    t.decimal  "core_cost",  :precision => 10, :scale => 0
    t.decimal  "price",      :precision => 10, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "in_store_parts", :force => true do |t|
    t.integer  "on_hand"
    t.integer  "max"
    t.integer  "min"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "part_purchase_orders", :force => true do |t|
    t.integer  "part_id"
    t.integer  "purchase_order_id"
    t.datetime "date_counted"
    t.integer  "count_qty"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "part_purchase_orders", ["part_id", "purchase_order_id"], :name => "index_part_purchase_orders_on_part_id_and_purchase_order_id"

  create_table "parts", :force => true do |t|
    t.integer  "product_line_id"
    t.string   "part_num",                                                       :null => false
    t.string   "description",                                    :default => ""
    t.decimal  "price0",          :precision => 10, :scale => 2
    t.decimal  "price1",          :precision => 10, :scale => 2
    t.decimal  "price2",          :precision => 10, :scale => 2
    t.decimal  "price3",          :precision => 10, :scale => 2
    t.decimal  "price4",          :precision => 10, :scale => 2
    t.decimal  "price5",          :precision => 10, :scale => 2
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "parts", ["part_num"], :name => "index_parts_on_part_num"
  add_index "parts", ["product_line_id", "part_num"], :name => "index_parts_on_product_line_and_part_num"

  create_table "parts_from_prices", :force => true do |t|
    t.integer "product_line_id"
    t.string  "part_num",                                       :null => false
    t.decimal "price0",          :precision => 10, :scale => 2
    t.decimal "price1",          :precision => 10, :scale => 2
    t.decimal "price2",          :precision => 10, :scale => 2
    t.decimal "price3",          :precision => 10, :scale => 2
    t.decimal "price4",          :precision => 10, :scale => 2
    t.decimal "price5",          :precision => 10, :scale => 2
  end

  add_index "parts_from_prices", ["part_num"], :name => "index_parts_from_prices_on_part_num"

  create_table "parts_from_sales", :force => true do |t|
    t.integer  "product_line_id"
    t.string   "part_num",        :limit => 20,                 :null => false
    t.string   "description",                   :default => ""
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "parts_from_sales", ["part_num"], :name => "index_parts_from_sales_on_part_num"

  create_table "product_lines", :force => true do |t|
    t.string   "description"
    t.text     "notes"
    t.string   "prefix"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "old_id"
  end

  create_table "purchase_orders", :force => true do |t|
    t.datetime "order_date"
    t.datetime "delivery_date"
    t.string   "po_num",        :limit => 15, :default => ""
    t.boolean  "is_open",                     :default => true
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "customer_id"
  end

end
