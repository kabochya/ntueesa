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

ActiveRecord::Schema.define(version: 20140731185707) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "image_link"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "department_books", force: true do |t|
    t.string   "course"
    t.integer  "adjustment"
    t.integer  "department_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "department_books", ["book_id"], name: "index_department_books_on_book_id", using: :btree
  add_index "department_books", ["department_id"], name: "index_department_books_on_department_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "dept_account",        default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dept_code"
  end

  add_index "departments", ["dept_account"], name: "index_departments_on_dept_account", unique: true, using: :btree

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.boolean  "is_paid",      default: false
    t.boolean  "is_confirmed", default: false
    t.string   "payment_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "purchases", force: true do |t|
    t.integer  "book_id"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["book_id"], name: "index_purchases_on_book_id", using: :btree
  add_index "purchases", ["payment_id"], name: "index_purchases_on_payment_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "account"
    t.string   "password"
    t.integer  "department_id"
    t.integer  "login_count",   default: 0
    t.string   "type"
    t.boolean  "is_member"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
