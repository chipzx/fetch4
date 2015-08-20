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

ActiveRecord::Schema.define(version: 20150820101946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.integer  "atype_id",       null: false
    t.string   "anumber",        null: false
    t.string   "name"
    t.integer  "kennel_id"
    t.integer  "gender_id"
    t.string   "breed"
    t.string   "coloring"
    t.decimal  "weight"
    t.datetime "dob"
    t.boolean  "dob_known"
    t.datetime "intake_date"
    t.integer  "intake_type_id"
    t.text     "description"
    t.integer  "group_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "animals", ["anumber", "group_id"], name: "index_animals_on_anumber_and_group_id", unique: true, using: :btree
  add_index "animals", ["group_id"], name: "index_animals_on_group_id", using: :btree
  add_index "animals", ["name"], name: "index_animals_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
