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

ActiveRecord::Schema.define(:version => 20120617154030) do

  create_table "deals", :force => true do |t|
    t.integer  "highrise_id"
    t.string   "name"
    t.string   "currency"
    t.integer  "price"
    t.string   "status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "author_id"
    t.date     "status_changed_on"
    t.datetime "highrise_created_at"
  end

  add_index "deals", ["highrise_id"], :name => "index_deals_on_highrise_id"
  add_index "deals", ["status"], :name => "index_deals_on_status"

  create_table "movements", :force => true do |t|
    t.integer  "total"
    t.string   "subject"
    t.date     "date"
    t.boolean  "income"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "checksum"
    t.integer  "balance"
  end

  add_index "movements", ["checksum"], :name => "index_movements_on_checksum"

end
