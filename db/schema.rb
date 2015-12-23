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

ActiveRecord::Schema.define(version: 20151222215920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "group_id",    null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "animal_types", ["group_id", "name"], name: "index_animal_types_on_group_id_and_name", unique: true, using: :btree
  add_index "animal_types", ["name"], name: "index_animal_types_on_name", using: :btree

  create_table "animals", force: :cascade do |t|
    t.integer  "animal_type_id",               null: false
    t.string   "anumber",                      null: false
    t.string   "name"
    t.integer  "kennel_id"
    t.integer  "gender_id"
    t.string   "breed"
    t.string   "coloring"
    t.decimal  "weight"
    t.datetime "dob"
    t.boolean  "dob_known"
    t.datetime "intake_date"
    t.integer  "intake_type_id",   default: 0, null: false
    t.text     "description"
    t.integer  "group_id",                     null: false
    t.string   "microchip_number"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "animals", ["anumber", "group_id"], name: "index_animals_on_anumber_and_group_id", unique: true, using: :btree
  add_index "animals", ["breed"], name: "index_animals_on_breed", using: :btree
  add_index "animals", ["group_id"], name: "index_animals_on_group_id", using: :btree
  add_index "animals", ["intake_type_id"], name: "index_animals_on_intake_type_id", using: :btree
  add_index "animals", ["kennel_id"], name: "index_animals_on_kennel_id", using: :btree
  add_index "animals", ["microchip_number"], name: "index_animals_on_microchip_number", using: :btree
  add_index "animals", ["name"], name: "index_animals_on_name", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "time_zone",   null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "intake_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "group_id",    null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "intake_types", ["group_id", "name"], name: "index_intake_types_on_group_id_and_name", unique: true, using: :btree
  add_index "intake_types", ["name"], name: "index_intake_types_on_name", using: :btree

  create_table "outcome_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "group_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "outcome_types", ["group_id", "name"], name: "index_outcome_types_on_group_id_and_name", unique: true, using: :btree
  add_index "outcome_types", ["name"], name: "index_outcome_types_on_name", using: :btree

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "group_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "animal_types", "groups", name: "animal_types_groups_fk"
  add_foreign_key "animals", "animal_types", name: "animals_animal_types_fk"
  add_foreign_key "animals", "groups", name: "animals_groups_fk"
  add_foreign_key "animals", "intake_types", name: "animals_intake_types_fk"
  add_foreign_key "intake_types", "groups", name: "intake_types_groups_fk"
  add_foreign_key "outcome_types", "groups", name: "outcome_types_groups_fk"
  add_foreign_key "users", "groups", name: "users_groups_fk"
end
