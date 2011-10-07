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

ActiveRecord::Schema.define(:version => 20111007140505) do

  create_table "cust_infs", :force => true do |t|
    t.integer  "CustId"
    t.string   "Trans_id"
    t.string   "Slip_No"
    t.string   "CName"
    t.string   "Contact_No"
    t.string   "Alt_Con_No"
    t.string   "Address"
    t.string   "State"
    t.string   "City"
    t.integer  "PinCode"
    t.date     "Date_of_reg"
    t.decimal  "Amount",      :precision => 8, :scale => 2, :default => 0.0
    t.string   "SmartcardNo"
    t.boolean  "Installed"
    t.string   "Remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "install_books", :force => true do |t|
    t.integer  "cust_inf_id"
    t.integer  "CustId"
    t.string   "GSK_No"
    t.string   "GSK_Pin"
    t.string   "RCV_No"
    t.string   "RCV_Pin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "Slip_Trans_id"
    t.string   "SmartcardNo"
    t.boolean  "Installed"
    t.string   "Remarks"
  end

  create_table "statecity", :force => true do |t|
    t.string   "State"
    t.string   "City"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
