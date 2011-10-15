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

ActiveRecord::Schema.define(:version => 20111011171354) do

  create_table "cust_infs", :force => true do |t|
    t.integer  "cust_id"
    t.string   "trans_id"
    t.string   "slip_no"
    t.string   "cname"
    t.string   "contact_no"
    t.string   "alt_con_no"
    t.string   "address"
    t.string   "state"
    t.string   "city"
    t.integer  "pincode"
    t.date     "date_of_reg"
    t.decimal  "amount",      :precision => 8, :scale => 2, :default => 0.0
    t.string   "smartcardno"
    t.boolean  "installed"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delete_flag",                               :default => 0
  end

  create_table "install_books", :force => true do |t|
    t.integer  "cust_inf_id"
    t.integer  "cust_id"
    t.string   "gsk_no"
    t.string   "gsk_pin"
    t.string   "rcv_no"
    t.string   "rcv_pin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slip_trans_id"
    t.string   "smartcardno"
    t.boolean  "installed"
    t.string   "remarks"
    t.integer  "delete_flag",   :default => 0
  end

  create_table "roles", :force => true do |t|
    t.string   "rolename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statecity", :force => true do |t|
    t.string   "state"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swamaan_lists", :force => true do |t|
    t.integer  "swamaan_id"
    t.string   "swamaan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "email"
    t.string   "persistence_token"
    t.integer  "roles_mask"
  end

  create_table "users_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_roles", ["role_id"], :name => "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id"], :name => "index_users_roles_on_user_id"

end
