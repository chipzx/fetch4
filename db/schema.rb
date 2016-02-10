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

ActiveRecord::Schema.define(version: 20160209173927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addr_to_outcome_map", id: false, force: :cascade do |t|
    t.integer  "address_id"
    t.integer  "outcome_id"
    t.string   "person_id"
    t.string   "animal_id"
    t.string   "name"
    t.datetime "outcome_date"
    t.text     "full_location"
  end

  create_table "address_types", force: :cascade do |t|
    t.string   "name",                    null: false
    t.text     "description"
    t.integer  "precedence",  default: 3, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "address_types", ["name"], name: "index_address_types_uidx", unique: true, using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "party_id",         null: false
    t.integer  "address_type_id",  null: false
    t.string   "street_address_1", null: false
    t.string   "street_address_2"
    t.string   "city",             null: false
    t.string   "county"
    t.string   "state",            null: false
    t.string   "postal_code",      null: false
    t.string   "country",          null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "geo_quality_code"
    t.string   "feature_type"
    t.boolean  "partial_match"
    t.boolean  "valid_address"
    t.text     "full_location"
  end

  add_index "addresses", ["address_type_id"], name: "index_addresses_on_address_type_id", using: :btree
  add_index "addresses", ["city"], name: "index_addresses_on_city", using: :btree
  add_index "addresses", ["full_location"], name: "index_addresses_on_full_location", using: :btree
  add_index "addresses", ["geo_quality_code"], name: "index_addresses_on_geo_quality_code", using: :btree
  add_index "addresses", ["party_id", "street_address_1", "street_address_2", "city", "state", "postal_code", "country", "address_type_id"], name: "index_addresses_uidx", unique: true, using: :btree
  add_index "addresses", ["postal_code"], name: "index_addresses_on_postal_code", using: :btree
  add_index "addresses", ["state"], name: "index_addresses_on_state", using: :btree

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

  create_table "bastrop_intakes", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "animal_type_id"
    t.string   "animal_id"
    t.string   "name"
    t.integer  "group_id"
    t.datetime "intake_date"
    t.integer  "intake_type_id"
    t.string   "found_location"
    t.string   "postal_code"
    t.integer  "address_id"
    t.integer  "gender_id"
    t.string   "breed"
    t.string   "coloring"
    t.string   "age"
    t.float    "weight"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "geo_quality_code"
    t.boolean  "parseable_address"
    t.boolean  "valid_address"
    t.integer  "fiscal_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_pks", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "party_id"
    t.integer  "contact_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contact_pks", ["contact_id"], name: "index_contact_pks_contact_id_uidx", unique: true, using: :btree
  add_index "contact_pks", ["party_id", "contact_id"], name: "index_contact_pks_party_id_uidx", unique: true, using: :btree

  create_table "contact_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contact_types", ["name"], name: "index_contact_types_uidx", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "contact_type_id", null: false
    t.integer  "party_id",        null: false
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contacts", ["contact_type_id"], name: "index_contacts_on_contact_type_id", using: :btree
  add_index "contacts", ["party_id", "contact_type_id"], name: "index_contacts_on_party_id_and_contact_type_id", using: :btree

  create_table "dropme", id: false, force: :cascade do |t|
    t.string   "animal_id"
    t.integer  "animal_type_id"
    t.string   "name"
    t.integer  "outcome_type_id"
    t.date     "outcome_date"
    t.text     "breed"
    t.text     "color"
    t.date     "dob"
    t.boolean  "bool"
    t.integer  "?column?"
    t.string   "microchip_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_contacts", force: :cascade do |t|
    t.integer  "contact_type_id",                 null: false
    t.integer  "party_id",                        null: false
    t.text     "description"
    t.string   "email",                           null: false
    t.boolean  "is_primary",      default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "email_contacts", ["contact_type_id"], name: "index_email_contacts_on_contact_type_id", using: :btree
  add_index "email_contacts", ["email"], name: "index_email_contacts_on_email", using: :btree
  add_index "email_contacts", ["party_id", "contact_type_id", "email"], name: "index_email_contacts_uidx", unique: true, using: :btree

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
    t.string   "name",                                           null: false
    t.string   "time_zone",                                      null: false
    t.text     "description"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.float    "center_point_latitude"
    t.float    "center_point_longitude"
    t.integer  "default_zoom_level"
    t.float    "max_intensity"
    t.string   "display_name"
    t.string   "fiscal_year_start",      default: "January 1",   null: false
    t.string   "fiscal_year_end",        default: "December 31", null: false
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

  create_table "media_contacts", force: :cascade do |t|
    t.integer  "contact_type_id", null: false
    t.integer  "party_id",        null: false
    t.text     "description"
    t.integer  "media_type_id",   null: false
    t.text     "uri",             null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "media_contacts", ["contact_type_id"], name: "index_media_contacts_on_contact_type_id", using: :btree
  add_index "media_contacts", ["media_type_id", "uri", "party_id", "contact_type_id"], name: "index_media_contacts_uidx", unique: true, using: :btree
  add_index "media_contacts", ["party_id"], name: "index_media_contacts_on_party_id", using: :btree

  create_table "media_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "media_uri"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "media_types", ["name", "media_uri"], name: "index_media_types_uidx", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.integer  "party_type_id", null: false
    t.integer  "group_id",      null: false
    t.string   "name",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "organizations", ["group_id"], name: "index_organizations_on_group_id", using: :btree
  add_index "organizations", ["name"], name: "index_organizations_uidx", unique: true, using: :btree
  add_index "organizations", ["party_type_id"], name: "index_organizations_on_party_type_id", using: :btree

  create_table "outcome_person_map", id: false, force: :cascade do |t|
    t.string "person_id"
    t.string "animal_id"
    t.string "outcome_date"
    t.string "operation_type"
    t.string "operation_sub_type"
    t.string "arn"
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

  create_table "outcomes", force: :cascade do |t|
    t.integer  "animal_type_id",   null: false
    t.string   "animal_id",        null: false
    t.string   "name"
    t.integer  "outcome_type_id",  null: false
    t.datetime "outcome_date",     null: false
    t.integer  "gender_id",        null: false
    t.integer  "address_id"
    t.string   "breed"
    t.string   "coloring"
    t.decimal  "weight"
    t.datetime "dob"
    t.boolean  "dob_known"
    t.datetime "intake_date"
    t.integer  "intake_type_id"
    t.text     "description"
    t.integer  "group_id",         null: false
    t.string   "microchip_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "age"
    t.integer  "fiscal_year"
  end

  add_index "outcomes", ["animal_id", "outcome_type_id", "outcome_date", "group_id"], name: "outcomes_unique_idx", unique: true, using: :btree
  add_index "outcomes", ["group_id"], name: "index_outcomes_on_group_id", using: :btree
  add_index "outcomes", ["intake_type_id"], name: "index_outcomes_on_intake_type_id", using: :btree
  add_index "outcomes", ["microchip_number"], name: "index_outcomes_on_microchip_number", using: :btree
  add_index "outcomes", ["name"], name: "index_outcomes_on_name", using: :btree
  add_index "outcomes", ["outcome_type_id"], name: "index_outcomes_on_outcome_type_id", using: :btree

  create_table "parties", force: :cascade do |t|
    t.integer  "party_type_id", null: false
    t.integer  "group_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "parties", ["group_id"], name: "index_parties_on_group_id", using: :btree
  add_index "parties", ["party_type_id"], name: "index_parties_on_party_type_id", using: :btree

  create_table "party_pks", force: :cascade do |t|
    t.integer  "party_id"
    t.integer  "group_id"
    t.integer  "party_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "party_pks", ["group_id", "party_id"], name: "index_party_pks_group_id_uidx", unique: true, using: :btree
  add_index "party_pks", ["party_id"], name: "index_party_pks_party_id_uidx", unique: true, using: :btree
  add_index "party_pks", ["party_type_id", "party_id", "group_id"], name: "index_party_pks_party_type_id_uidx", unique: true, using: :btree

  create_table "party_relationships", force: :cascade do |t|
    t.integer  "party_id",             null: false
    t.integer  "related_party_id",     null: false
    t.integer  "relationship_type_id", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "party_relationships", ["party_id", "related_party_id", "relationship_type_id"], name: "index_party_relationships_uidx", unique: true, using: :btree
  add_index "party_relationships", ["related_party_id"], name: "index_party_relationships_on_related_party_id", using: :btree
  add_index "party_relationships", ["relationship_type_id"], name: "index_party_relationships_on_relationship_type_id", using: :btree

  create_table "party_roles", force: :cascade do |t|
    t.integer  "party_id"
    t.string   "role_name",  null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "party_roles", ["party_id", "role_name", "start_time"], name: "index_party_roles_uidx", unique: true, using: :btree

  create_table "party_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "party_types", ["name"], name: "index_party_types_uidx", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.integer  "party_type_id", null: false
    t.integer  "group_id",      null: false
    t.string   "first_name",    null: false
    t.string   "middle_name"
    t.string   "last_name",     null: false
    t.string   "salutation"
    t.string   "suffix"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "people", ["first_name", "last_name"], name: "index_people_on_first_name_and_last_name", using: :btree
  add_index "people", ["group_id"], name: "index_people_on_group_id", using: :btree
  add_index "people", ["last_name", "first_name", "middle_name"], name: "index_people_on_last_name_and_first_name_and_middle_name", using: :btree
  add_index "people", ["party_type_id"], name: "index_people_on_party_type_id", using: :btree

  create_table "person_id_map", id: false, force: :cascade do |t|
    t.string  "person_id"
    t.integer "party_id",  limit: 8
  end

  create_table "phone_contacts", force: :cascade do |t|
    t.integer  "contact_type_id",                   null: false
    t.integer  "party_id",                          null: false
    t.text     "description"
    t.string   "country_code",    default: "01",    null: false
    t.string   "phone_number",                      null: false
    t.string   "extension"
    t.string   "phone_type",      default: "other", null: false
    t.boolean  "is_primary",      default: false,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "phone_contacts", ["contact_type_id"], name: "index_phone_contacts_on_contact_type_id", using: :btree
  add_index "phone_contacts", ["country_code", "phone_number", "extension", "phone_type", "party_id", "contact_type_id"], name: "index_phone_contacts_uidx", unique: true, using: :btree
  add_index "phone_contacts", ["party_id"], name: "index_phone_contacts_on_party_id", using: :btree
  add_index "phone_contacts", ["phone_number"], name: "index_phone_contacts_on_phone_number", using: :btree
  add_index "phone_contacts", ["phone_type"], name: "index_phone_contacts_on_phone_type", using: :btree

  create_table "pp_extended_outcomes", id: false, force: :cascade do |t|
    t.string "animal_id"
    t.string "arn"
    t.string "microchip_number"
    t.string "name"
    t.string "animal_type"
    t.string "primary_breed"
    t.string "secondary_breed"
    t.string "dob"
    t.string "gender"
    t.string "spayed_or_neutered"
    t.string "prealtered"
    t.string "danger"
    t.string "danger_reason"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "operation_type"
    t.string "operation_sub_type"
    t.string "outcome_date"
    t.string "outcome_date_time"
    t.string "outcome_age_as_month"
    t.string "by"
    t.string "age_group"
    t.string "altered"
    t.string "site_name"
    t.string "outcome_reason"
    t.string "jurisdiction_out"
    t.string "asilomar_status"
    t.string "full_gender"
  end

  create_table "pp_person_by_operation", id: false, force: :cascade do |t|
    t.string "person_id"
    t.string "first_name"
    t.string "last_name"
    t.string "salutation"
    t.string "date_created"
    t.string "person_gender"
    t.string "street_number"
    t.string "street_name"
    t.string "street_type"
    t.string "street_direction"
    t.string "street_direction2"
    t.string "unit_number"
    t.string "city"
    t.string "city_alias"
    t.string "province_abbr"
    t.string "postal_code"
    t.string "address_combined"
    t.string "contact_by_address"
    t.string "jurisdiction"
    t.string "county"
    t.string "phone_number"
    t.string "contact_by_phone"
    t.string "email"
    t.string "contact_by_email"
    t.string "operation_type"
    t.string "operation_sub_type"
    t.string "operation_date"
    t.string "operation_by"
    t.string "animal_id"
    t.string "arn"
    t.string "name"
    t.string "petid"
    t.string "animal_type"
    t.string "dob"
    t.string "microchip_number"
    t.string "microchip_issuer"
    t.string "location"
    t.string "site"
    t.string "primary_breed"
    t.string "secondary_breed"
    t.string "gender"
    t.string "primary_color"
    t.string "spayed_or_neutered"
    t.string "age_in_months"
    t.string "weight"
    t.string "body_weight_unit"
    t.string "opt_in"
    t.string "opt_in_consent"
    t.string "opt_in_created_in"
    t.string "opt_in_created_by"
    t.string "opt_in_created_timestamp"
    t.string "opt_in_email"
    t.string "opt_in_email_consent"
    t.string "opt_in_email_created_in"
    t.string "opt_in_email_created_by"
    t.string "opt_in_email_created_timestamp"
    t.string "opt_in_mail"
    t.string "opt_in_mail_consent"
    t.string "opt_in_mail_created_in"
    t.string "opt_in_mail_created_by"
    t.string "opt_in_mail_created_timestamp"
  end

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

  create_table "relationship_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationship_types", ["name"], name: "index_relationship_types_uidx", unique: true, using: :btree

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

  add_foreign_key "addresses", "address_types", name: "addresses_address_type_id_fk"
  add_foreign_key "addresses", "party_pks", column: "party_id", primary_key: "party_id", name: "addresses_party_id_fk", on_delete: :cascade
  add_foreign_key "animal_galleries", "animals", name: "animal_animal_galleries_fk"
  add_foreign_key "animal_types", "groups", name: "animal_types_groups_fk"
  add_foreign_key "animals", "animal_types", name: "animals_animal_types_fk"
  add_foreign_key "animals", "groups", name: "animals_groups_fk"
  add_foreign_key "animals", "intake_types", name: "animals_intake_types_fk"
  add_foreign_key "contact_pks", "party_pks", column: "party_id", primary_key: "party_id", name: "contact_pks_parties_party_id_fk", on_delete: :cascade
  add_foreign_key "contacts", "contact_types", name: "contacts_contact_type_id_fk"
  add_foreign_key "contacts", "party_pks", column: "party_id", primary_key: "party_id", name: "contacts_parties_party_id_fk", on_delete: :cascade
  add_foreign_key "email_contacts", "contact_pks", column: "id", primary_key: "contact_id", name: "email_contacts_pk_contact_id_fk", on_delete: :cascade
  add_foreign_key "email_contacts", "contact_types", name: "email_contacts_contact_type_id_fk"
  add_foreign_key "genders", "groups", name: "genders_groups_fk"
  add_foreign_key "intake_types", "groups", name: "intake_types_groups_fk"
  add_foreign_key "intakes", "animal_types", name: "intakes_animal_type_id_fk"
  add_foreign_key "intakes", "genders", name: "intakes_gender_id_fk"
  add_foreign_key "intakes", "groups", name: "intakes_group_id_fk"
  add_foreign_key "intakes", "intake_types", name: "intakes_intake_type_id_fk"
  add_foreign_key "kennel_types", "groups", name: "kennel_types_groups_fk"
  add_foreign_key "kennels", "groups", name: "kennels_groups"
  add_foreign_key "kennels", "kennel_types", name: "kennels_kennel_types"
  add_foreign_key "media_contacts", "contact_pks", column: "id", primary_key: "contact_id", name: "media_contacts_pk_contact_id_fk", on_delete: :cascade
  add_foreign_key "media_contacts", "contact_types", name: "media_contacts_contact_type_id_fk"
  add_foreign_key "media_contacts", "media_types", name: "media_contacts_media_type_fk"
  add_foreign_key "organizations", "groups", name: "organizations_group_id_fk"
  add_foreign_key "outcome_types", "groups", name: "outcome_types_groups_fk"
  add_foreign_key "outcomes", "animal_types", name: "outcomes_animal_type_fk"
  add_foreign_key "outcomes", "groups", name: "outcomes_group_fk"
  add_foreign_key "outcomes", "intake_types", name: "outcomes_intake_type_fk"
  add_foreign_key "outcomes", "outcome_types", name: "outcomes_outcome_type_fk"
  add_foreign_key "parties", "groups", name: "parties_group_id_fk"
  add_foreign_key "parties", "party_types", name: "parties_party_type_id_fk"
  add_foreign_key "party_relationships", "party_pks", column: "party_id", primary_key: "party_id", name: "party_relationships_parent_id_fk"
  add_foreign_key "party_relationships", "party_pks", column: "related_party_id", primary_key: "party_id", name: "party_relationships_child_id_fk", on_delete: :cascade
  add_foreign_key "party_relationships", "relationship_types", name: "party_relationships_relationship_type_id_fk", on_delete: :cascade
  add_foreign_key "party_roles", "party_pks", column: "party_id", primary_key: "party_id", name: "party_roles_party_id_fk", on_delete: :cascade
  add_foreign_key "people", "groups", name: "people_group_id_fk"
  add_foreign_key "phone_contacts", "contact_pks", column: "id", primary_key: "contact_id", name: "phone_contacts_pk_contact_id_fk", on_delete: :cascade
  add_foreign_key "phone_contacts", "contact_types", name: "phone_contacts_contact_type_id_fk"
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

  create_view :intake_heatmaps,  sql_definition: <<-SQL
      SELECT i.group_id,
      i.found_location,
      i.latitude,
      i.longitude,
      at.name AS animal_type,
      it.name AS intake_type,
      g.description AS gender,
      i.fiscal_year,
      count(*) AS total
     FROM (((intakes i
       JOIN intake_types it ON ((it.id = i.intake_type_id)))
       JOIN animal_types at ON ((at.id = i.animal_type_id)))
       JOIN genders g ON ((g.id = i.gender_id)))
    WHERE (((i.latitude IS NOT NULL) AND (i.latitude <> (0.0)::double precision)) AND i.valid_address)
    GROUP BY i.group_id, i.found_location, i.latitude, i.longitude, at.name, it.name, g.description, i.fiscal_year;
  SQL

  create_view :hotspots,  sql_definition: <<-SQL
      SELECT intakes.found_location,
      intakes.latitude,
      intakes.longitude,
      at.name AS animal_type,
      g.name AS gender,
      it.name AS intake_type,
      intakes.group_id,
      intakes.fiscal_year,
      count(*) AS total
     FROM (((intakes
       JOIN intake_types it ON ((it.id = intakes.intake_type_id)))
       JOIN animal_types at ON ((at.id = intakes.animal_type_id)))
       JOIN genders g ON ((g.id = intakes.gender_id)))
    WHERE (((intakes.found_location)::text IN ( SELECT hs.found_location
             FROM ( SELECT intakes_1.found_location,
                      intakes_1.latitude,
                      intakes_1.longitude,
                      intakes_1.group_id,
                      count(*) AS count
                     FROM intakes intakes_1
                    WHERE (intakes_1.valid_address AND (intakes_1.latitude IS NOT NULL))
                    GROUP BY intakes_1.found_location, intakes_1.latitude, intakes_1.longitude, intakes_1.group_id
                   HAVING (count(*) >= 20)) hs)) AND (intakes.latitude IS NOT NULL))
    GROUP BY intakes.found_location, intakes.latitude, intakes.longitude, at.name, g.name, it.name, intakes.fiscal_year, intakes.group_id;
  SQL

  create_view :hotspot_details,  sql_definition: <<-SQL
      SELECT hotspots.found_location,
      hotspots.latitude,
      hotspots.longitude,
      hotspots.animal_type,
      hotspots.fiscal_year,
      hotspots.group_id,
      sum(hotspots.total) AS total
     FROM hotspots
    GROUP BY hotspots.found_location, hotspots.latitude, hotspots.longitude, hotspots.animal_type, hotspots.fiscal_year, hotspots.group_id
    ORDER BY hotspots.group_id, hotspots.found_location, hotspots.latitude, hotspots.longitude, hotspots.animal_type, hotspots.fiscal_year;
  SQL

  create_view :outcome_heatmaps,  sql_definition: <<-SQL
      SELECT o.group_id,
      a.full_location AS found_location,
      a.latitude,
      a.longitude,
      at.name AS animal_type,
      ot.name AS outcome_type,
      g.description AS gender,
      o.fiscal_year,
      count(*) AS total
     FROM ((((outcomes o
       JOIN addresses a ON ((o.address_id = a.id)))
       JOIN outcome_types ot ON ((ot.id = o.outcome_type_id)))
       JOIN animal_types at ON ((at.id = o.animal_type_id)))
       JOIN genders g ON ((g.id = o.gender_id)))
    WHERE (((a.latitude IS NOT NULL) AND (a.latitude <> (0.0)::double precision)) AND a.valid_address)
    GROUP BY o.group_id, a.full_location, a.latitude, a.longitude, at.name, ot.name, g.description, o.fiscal_year;
  SQL

  create_view :day_count_during_years,  sql_definition: <<-SQL
      SELECT ad.fiscal_year,
      ad.group_id,
      to_char(ad.outcome_date, 'DY'::text) AS day_of_week,
      count(*) AS total_days
     FROM ( SELECT DISTINCT outcomes.fiscal_year,
              outcomes.group_id,
              outcomes.outcome_date
             FROM outcomes) ad
    GROUP BY ad.fiscal_year, ad.group_id, to_char(ad.outcome_date, 'DY'::text);
  SQL

  create_view :adoptions_by_days,  sql_definition: <<-SQL
      SELECT y.fiscal_year,
      to_char(o.outcome_date, 'D'::text) AS day_index,
      to_char(o.outcome_date, 'DY'::text) AS day_of_week,
      y.total_days,
      y.group_id,
      count(*) AS number_adoptions,
      round((((count(*))::numeric * 1.0) / ((y.total_days)::numeric * 1.0)), 2) AS avg_daily_adoptions
     FROM (outcomes o
       JOIN day_count_during_years y ON ((((to_char(o.outcome_date, 'DY'::text) = y.day_of_week) AND (o.fiscal_year = y.fiscal_year)) AND (o.group_id = y.group_id))))
    WHERE (o.outcome_type_id = ( SELECT ot.id
             FROM outcome_types ot
            WHERE ((ot.group_id = o.group_id) AND ((ot.name)::text = 'Adoption'::text))))
    GROUP BY y.fiscal_year, y.group_id, y.total_days, to_char(o.outcome_date, 'DY'::text), to_char(o.outcome_date, 'D'::text);
  SQL

end
