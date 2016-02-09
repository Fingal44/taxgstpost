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

ActiveRecord::Schema.define(version: 20160209030533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_tables", force: :cascade do |t|
    t.string   "name"
    t.date     "lastmodified"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "chart_clones", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cc_id"
  end

  create_table "charts", force: :cascade do |t|
    t.integer  "glcode"
    t.integer  "gst"
    t.integer  "code",                                null: false
    t.string   "content"
    t.integer  "header"
    t.integer  "users_id"
    t.decimal  "amount_1",   precision: 10, scale: 2
    t.decimal  "amount_2",   precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "charts", ["code"], name: "index_charts_on_code", using: :btree
  add_index "charts", ["glcode"], name: "index_charts_on_glcode", using: :btree
  add_index "charts", ["users_id"], name: "index_charts_on_users_id", using: :btree

  create_table "datesettings", force: :cascade do |t|
    t.integer  "users_id",   null: false
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "datesettings", ["users_id"], name: "index_datesettings_on_users_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.integer  "irdcode"
    t.string   "taxcode"
    t.decimal  "accprocent", precision: 10, scale: 2
    t.integer  "users_id"
    t.string   "fio"
    t.decimal  "taxprocent", precision: 10, scale: 2
    t.integer  "kiwisaver"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "employees", ["fio"], name: "index_employees_on_fio", using: :btree
  add_index "employees", ["irdcode"], name: "index_employees_on_irdcode", using: :btree
  add_index "employees", ["users_id"], name: "index_employees_on_users_id", using: :btree

  create_table "future_transactions", force: :cascade do |t|
    t.date     "date",                                     null: false
    t.integer  "code",                                     null: false
    t.decimal  "amounttotal",     precision: 10, scale: 2
    t.integer  "gsttype"
    t.decimal  "gstamount",       precision: 10, scale: 2
    t.decimal  "netamount",       precision: 10, scale: 2
    t.integer  "users_id",                                 null: false
    t.integer  "chart_clones_id",                          null: false
    t.integer  "co"
    t.integer  "gst_include"
    t.integer  "for_moving"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "future_transactions", ["chart_clones_id"], name: "index_future_transactions_on_chart_clones_id", using: :btree
  add_index "future_transactions", ["code"], name: "index_future_transactions_on_code", using: :btree
  add_index "future_transactions", ["date"], name: "index_future_transactions_on_date", using: :btree
  add_index "future_transactions", ["users_id"], name: "index_future_transactions_on_users_id", using: :btree

  create_table "temp_transactions", force: :cascade do |t|
    t.date     "date"
    t.decimal  "amounttotal",     precision: 10, scale: 2
    t.integer  "gsttype"
    t.decimal  "gstamount",       precision: 10, scale: 2
    t.decimal  "netamount",       precision: 10, scale: 2
    t.integer  "co"
    t.integer  "code"
    t.integer  "users_id",                                 null: false
    t.integer  "chart_clones_id"
    t.string   "what"
    t.string   "who"
    t.integer  "gst_include"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "temp_transactions", ["chart_clones_id"], name: "index_temp_transactions_on_chart_clones_id", using: :btree
  add_index "temp_transactions", ["code"], name: "index_temp_transactions_on_code", using: :btree
  add_index "temp_transactions", ["date"], name: "index_temp_transactions_on_date", using: :btree
  add_index "temp_transactions", ["users_id"], name: "index_temp_transactions_on_users_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.date     "date",                                     null: false
    t.integer  "code",                                     null: false
    t.decimal  "amounttotal",     precision: 10, scale: 2
    t.integer  "gsttype"
    t.decimal  "gstamount",       precision: 10, scale: 2
    t.decimal  "netamount",       precision: 10, scale: 2
    t.integer  "users_id",                                 null: false
    t.integer  "chart_clones_id",                          null: false
    t.integer  "co"
    t.integer  "gst_include"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["chart_clones_id"], name: "index_transactions_on_chart_clones_id", using: :btree
  add_index "transactions", ["code"], name: "index_transactions_on_code", using: :btree
  add_index "transactions", ["date"], name: "index_transactions_on_date", using: :btree
  add_index "transactions", ["users_id"], name: "index_transactions_on_users_id", using: :btree

  create_table "transferings", force: :cascade do |t|
    t.string   "argb"
    t.string   "argn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "category"
    t.date     "expire_date"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
