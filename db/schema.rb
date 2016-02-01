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

ActiveRecord::Schema.define(version: 20160201182518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_galleries", force: :cascade do |t|
    t.integer  "animal_id",                          null: false
    t.boolean  "primary_image",      default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "animal_galleries", ["animal_id"], name: "index_animal_galleries_on_animal_id", using: :btree

  create_table "animal_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "group_id",    null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "animal_types", ["group_id", "name"], name: "index_animal_types_on_group_id_and_name", unique: true, using: :btree
  add_index "animal_types", ["name"], name: "index_animal_types_on_name", using: :btree

  create_table "animal_types_dump", id: false, force: :cascade do |t|
    t.integer  "id",                      null: false
    t.string   "name",        limit: 255, null: false
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

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

  create_table "animals_dump", id: false, force: :cascade do |t|
    t.integer  "id",                             null: false
    t.integer  "atype_id",                       null: false
    t.string   "anumber",            limit: 255, null: false
    t.string   "name",               limit: 255
    t.integer  "kennel_id"
    t.integer  "gender_id"
    t.string   "breed",              limit: 255
    t.string   "coloring",           limit: 255
    t.datetime "dob"
    t.boolean  "dob_known"
    t.datetime "intake_date"
    t.integer  "intake_type_id"
    t.text     "description"
    t.integer  "group_id",                       null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "weight"
    t.datetime "last_modified_time",             null: false
    t.string   "last_modified_by",   limit: 255, null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.integer  "group_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "genders", ["group_id"], name: "index_genders_on_group_id", using: :btree
  add_index "genders", ["name", "group_id"], name: "index_genders_on_name_and_group_id", unique: true, using: :btree

  create_table "genders_dump", id: false, force: :cascade do |t|
    t.integer  "id",                      null: false
    t.string   "indicator",   limit: 1,   null: false
    t.string   "description", limit: 128, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "time_zone",              null: false
    t.text     "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "center_point_latitude"
    t.float    "center_point_longitude"
    t.integer  "default_zoom_level"
    t.float    "max_intensity"
    t.string   "display_name"
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

  create_table "intake_types_dump", id: false, force: :cascade do |t|
    t.integer  "id",                      null: false
    t.string   "indicator",   limit: 255, null: false
    t.string   "description", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "intakes", force: :cascade do |t|
    t.integer  "animal_type_id",    null: false
    t.string   "animal_id",         null: false
    t.string   "name"
    t.integer  "group_id",          null: false
    t.datetime "intake_date"
    t.integer  "intake_type_id",    null: false
    t.string   "found_location"
    t.string   "postal_code"
    t.integer  "address_id"
    t.integer  "gender_id",         null: false
    t.string   "breed"
    t.string   "coloring"
    t.string   "age"
    t.float    "weight"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "geo_quality_code"
    t.boolean  "parseable_address"
    t.boolean  "valid_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "fiscal_year"
  end

  add_index "intakes", ["animal_id", "intake_date", "group_id"], name: "index_intakes_on_animal_id_and_intake_date_and_group_id", unique: true, using: :btree
  add_index "intakes", ["geo_quality_code"], name: "index_intakes_on_geo_quality_code", using: :btree
  add_index "intakes", ["group_id"], name: "index_intakes_on_group_id", using: :btree
  add_index "intakes", ["intake_date"], name: "index_intakes_on_intake_date", using: :btree
  add_index "intakes", ["intake_type_id"], name: "index_intakes_on_intake_type_id", using: :btree
  add_index "intakes", ["postal_code"], name: "index_intakes_on_postal_code", using: :btree

  create_table "kennel_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "group_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "kennel_types", ["group_id"], name: "index_kennel_types_on_group_id", using: :btree
  add_index "kennel_types", ["name", "group_id"], name: "index_kennel_types_on_name_and_group_id", unique: true, using: :btree

  create_table "kennels", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "building"
    t.integer  "kennel_type_id",                 null: false
    t.integer  "max_occupancy",  default: 1,     null: false
    t.boolean  "full_name",      default: false, null: false
    t.boolean  "is_onsite",      default: true,  null: false
    t.boolean  "is_public",      default: true,  null: false
    t.boolean  "is_permanent",   default: true,  null: false
    t.boolean  "is_available",   default: true,  null: false
    t.integer  "group_id",                       null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "kennels", ["group_id"], name: "index_kennels_on_group_id", using: :btree
  add_index "kennels", ["name", "building", "group_id"], name: "index_kennels_on_name_and_building_and_group_id", unique: true, using: :btree

  create_table "kennels_dump", id: false, force: :cascade do |t|
    t.integer  "id",                                        null: false
    t.string   "name",          limit: 255,                 null: false
    t.string   "bldg",          limit: 255
    t.string   "kennel_type",   limit: 255
    t.integer  "max_occupancy",             default: 1
    t.boolean  "full_name",                 default: false
    t.integer  "group_id",                                  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_public",                 default: false
    t.boolean  "is_onsite",                 default: true
    t.boolean  "is_permanent",              default: true
  end

  create_table "outcome_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "group_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "outcome_types", ["group_id", "name"], name: "index_outcome_types_on_group_id_and_name", unique: true, using: :btree
  add_index "outcome_types", ["name"], name: "index_outcome_types_on_name", using: :btree

  create_table "privileges", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "right_id",   null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "privileges", ["group_id"], name: "index_privileges_on_group_id", using: :btree
  add_index "privileges", ["right_id"], name: "index_privileges_on_right_id", using: :btree
  add_index "privileges", ["user_id", "right_id"], name: "index_privileges_on_user_id_and_right_id", unique: true, using: :btree

  create_table "raw_intakes", force: :cascade do |t|
    t.string   "animal_id",         limit: 255
    t.string   "name",              limit: 255
    t.integer  "group_id",                                      null: false
    t.datetime "intake_date"
    t.string   "found_location",    limit: 255
    t.string   "intake_type",       limit: 255
    t.string   "animal_type",       limit: 255
    t.string   "gender",            limit: 255
    t.string   "breed",             limit: 255
    t.string   "color",             limit: 255
    t.boolean  "parseable_address"
    t.boolean  "valid_address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "geo_quality_code"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "age"
    t.string   "postal_code",       limit: 255
    t.string   "fiscal_year"
    t.boolean  "intake_location",               default: false, null: false
    t.integer  "animal_type_id"
    t.integer  "intake_type_id"
    t.integer  "gender_id"
  end

  create_table "rights", force: :cascade do |t|
    t.string   "resource",   null: false
    t.string   "action",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rights", ["resource", "action"], name: "index_rights_on_resource_and_action", unique: true, using: :btree

  create_table "role_rights", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.integer  "right_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id",   null: false
  end

  add_index "role_rights", ["group_id"], name: "index_role_rights_on_group_id", using: :btree
  add_index "role_rights", ["right_id"], name: "index_role_rights_on_right_id", using: :btree
  add_index "role_rights", ["role_id", "right_id", "group_id"], name: "index_role_rights_on_role_id_and_right_id_and_group_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",                       null: false
    t.text     "description",                null: false
    t.integer  "group_id",                   null: false
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "roles", ["group_id"], name: "index_roles_on_group_id", using: :btree
  add_index "roles", ["name", "group_id"], name: "index_roles_on_name_and_group_id", unique: true, using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["group_id"], name: "index_user_roles_on_group_id", using: :btree
  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true, using: :btree

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

  add_foreign_key "animal_galleries", "animals", name: "animal_animal_galleries_fk"
  add_foreign_key "animal_types", "groups", name: "animal_types_groups_fk"
  add_foreign_key "animals", "animal_types", name: "animals_animal_types_fk"
  add_foreign_key "animals", "groups", name: "animals_groups_fk"
  add_foreign_key "animals", "intake_types", name: "animals_intake_types_fk"
  add_foreign_key "genders", "groups", name: "genders_groups_fk"
  add_foreign_key "intake_types", "groups", name: "intake_types_groups_fk"
  add_foreign_key "intakes", "animal_types", name: "intakes_animal_type_id_fk"
  add_foreign_key "intakes", "genders", name: "intakes_gender_id_fk"
  add_foreign_key "intakes", "groups", name: "intakes_group_id_fk"
  add_foreign_key "intakes", "intake_types", name: "intakes_intake_type_id_fk"
  add_foreign_key "kennel_types", "groups", name: "kennel_types_groups_fk"
  add_foreign_key "kennels", "groups", name: "kennels_groups"
  add_foreign_key "kennels", "kennel_types", name: "kennels_kennel_types"
  add_foreign_key "outcome_types", "groups", name: "outcome_types_groups_fk"
  add_foreign_key "privileges", "groups", name: "privileges_groups_fk"
  add_foreign_key "privileges", "groups", name: "user_roles_groups_fk"
  add_foreign_key "privileges", "rights", name: "privileges_rights_fk"
  add_foreign_key "privileges", "rights", name: "user_roles_rights_fk"
  add_foreign_key "privileges", "users", name: "privileges_users_fk"
  add_foreign_key "role_rights", "groups", name: "role_rights_groups_fk"
  add_foreign_key "role_rights", "rights", name: "role_rights_rights_fk"
  add_foreign_key "role_rights", "roles", name: "role_rights_roles_fk"
  add_foreign_key "roles", "groups", name: "roles_groups_fk"
  add_foreign_key "user_roles", "users", name: "user_roles_users_fk"
  add_foreign_key "users", "groups", name: "users_groups_fk"
end
