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

ActiveRecord::Schema.define(version: 201307181255011) do

  create_table "global_property", primary_key: "property", force: :cascade do |t|
    t.text   "property_value", limit: 16777215
    t.text   "description",    limit: 65535
    t.string "uuid",           limit: 38,       null: false
  end

  add_index "global_property", ["uuid"], name: "global_property_uuid_index", unique: true, using: :btree

  create_table "location", primary_key: "location_id", force: :cascade do |t|
    t.string   "name",              limit: 255, default: "",    null: false
    t.string   "description",       limit: 255
    t.string   "address1",          limit: 50
    t.string   "address2",          limit: 50
    t.string   "city_village",      limit: 50
    t.string   "state_province",    limit: 50
    t.string   "postal_code",       limit: 50
    t.string   "country",           limit: 50
    t.string   "latitude",          limit: 50
    t.string   "longitude",         limit: 50
    t.integer  "creator",           limit: 4,   default: 0,     null: false
    t.datetime "date_created",                                  null: false
    t.string   "county_district",   limit: 50
    t.string   "neighborhood_cell", limit: 50
    t.string   "region",            limit: 50
    t.string   "subregion",         limit: 50
    t.string   "township_division", limit: 50
    t.boolean  "retired",           limit: 1,   default: false, null: false
    t.integer  "retired_by",        limit: 4
    t.datetime "date_retired"
    t.string   "retire_reason",     limit: 255
    t.integer  "location_type_id",  limit: 4
    t.integer  "parent_location",   limit: 4
    t.string   "uuid",              limit: 38,                  null: false
  end

  add_index "location", ["creator"], name: "user_who_created_location", using: :btree
  add_index "location", ["location_type_id"], name: "type_of_location", using: :btree
  add_index "location", ["name"], name: "name_of_location", using: :btree
  add_index "location", ["parent_location"], name: "parent_location", using: :btree
  add_index "location", ["retired"], name: "retired_status", using: :btree
  add_index "location", ["retired_by"], name: "user_who_retired_location", using: :btree
  add_index "location", ["uuid"], name: "location_uuid_index", unique: true, using: :btree

  create_table "person", primary_key: "person_id", force: :cascade do |t|
    t.string   "gender",              limit: 50,  default: ""
    t.date     "birthdate"
    t.integer  "birthdate_estimated", limit: 2,   default: 0,  null: false
    t.integer  "dead",                limit: 2,   default: 0,  null: false
    t.datetime "death_date"
    t.integer  "cause_of_death",      limit: 4
    t.integer  "creator",             limit: 4,   default: 0,  null: false
    t.datetime "date_created",                                 null: false
    t.integer  "changed_by",          limit: 4
    t.datetime "date_changed"
    t.integer  "voided",              limit: 2,   default: 0,  null: false
    t.integer  "voided_by",           limit: 4
    t.datetime "date_voided"
    t.string   "void_reason",         limit: 255
    t.string   "uuid",                limit: 38,               null: false
  end

  add_index "person", ["birthdate"], name: "person_birthdate", using: :btree
  add_index "person", ["cause_of_death"], name: "person_died_because", using: :btree
  add_index "person", ["changed_by"], name: "user_who_changed_pat", using: :btree
  add_index "person", ["creator"], name: "user_who_created_patient", using: :btree
  add_index "person", ["death_date"], name: "person_death_date", using: :btree
  add_index "person", ["uuid"], name: "person_uuid_index", unique: true, using: :btree
  add_index "person", ["voided_by"], name: "user_who_voided_patient", using: :btree

  create_table "person_name", primary_key: "person_name_id", force: :cascade do |t|
    t.integer  "preferred",          limit: 2,   default: 0, null: false
    t.integer  "person_id",          limit: 4
    t.string   "prefix",             limit: 50
    t.string   "given_name",         limit: 50
    t.string   "middle_name",        limit: 50
    t.string   "family_name_prefix", limit: 50
    t.string   "family_name",        limit: 50
    t.string   "family_name2",       limit: 50
    t.string   "family_name_suffix", limit: 50
    t.string   "degree",             limit: 50
    t.integer  "creator",            limit: 4,   default: 0, null: false
    t.datetime "date_created",                               null: false
    t.integer  "voided",             limit: 2,   default: 0, null: false
    t.integer  "voided_by",          limit: 4
    t.datetime "date_voided"
    t.string   "void_reason",        limit: 255
    t.integer  "changed_by",         limit: 4
    t.datetime "date_changed"
    t.string   "uuid",               limit: 38,              null: false
  end

  add_index "person_name", ["creator"], name: "user_who_made_name", using: :btree
  add_index "person_name", ["family_name"], name: "last_name", using: :btree
  add_index "person_name", ["family_name2"], name: "family_name2", using: :btree
  add_index "person_name", ["given_name"], name: "first_name", using: :btree
  add_index "person_name", ["middle_name"], name: "middle_name", using: :btree
  add_index "person_name", ["person_id"], name: "name_for_patient", using: :btree
  add_index "person_name", ["uuid"], name: "person_name_uuid_index", unique: true, using: :btree
  add_index "person_name", ["voided_by"], name: "user_who_voided_name", using: :btree

  create_table "privilege", id: false, force: :cascade do |t|
    t.string "privilege",   limit: 250
    t.string "description", limit: 250, default: "", null: false
    t.string "uuid",        limit: 38,               null: false
  end

  add_index "privilege", ["uuid"], name: "privilege_uuid_index", unique: true, using: :btree

  create_table "role", id: false, force: :cascade do |t|
    t.string  "role",          limit: 250
    t.string  "description",   limit: 255, default: "", null: false
    t.integer "vocabulary_id", limit: 4
    t.string  "uuid",          limit: 38,               null: false
  end

  add_index "role", ["uuid"], name: "role_uuid_index", unique: true, using: :btree

  create_table "role_privilege", id: false, force: :cascade do |t|
    t.string "role",      limit: 50, default: "", null: false
    t.string "privilege", limit: 50, default: "", null: false
  end

  add_index "role_privilege", ["role"], name: "role_privilege", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.text     "data",       limit: 65535
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "sessions_session_id_index", using: :btree

  create_table "user_property", id: false, force: :cascade do |t|
    t.integer "user_id",        limit: 4,   default: 0,  null: false
    t.string  "property",       limit: 100, default: "", null: false
    t.string  "property_value", limit: 255, default: "", null: false
  end

  create_table "user_role", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4,  default: 0,  null: false
    t.string  "role",    limit: 50, default: "", null: false
  end

  add_index "user_role", ["user_id"], name: "user_role", using: :btree

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "system_id",       limit: 50,  default: "", null: false
    t.string   "username",        limit: 50
    t.string   "password",        limit: 128
    t.string   "salt",            limit: 128
    t.string   "secret_question", limit: 255
    t.string   "secret_answer",   limit: 255
    t.integer  "creator",         limit: 4,   default: 0,  null: false
    t.datetime "date_created",                             null: false
    t.integer  "changed_by",      limit: 4
    t.datetime "date_changed"
    t.integer  "person_id",       limit: 4
    t.integer  "retired",         limit: 1,   default: 0,  null: false
    t.integer  "retired_by",      limit: 4
    t.datetime "date_retired"
    t.string   "retire_reason",   limit: 255
    t.string   "uuid",            limit: 38,               null: false
  end

  add_index "users", ["changed_by"], name: "user_who_changed_user", using: :btree
  add_index "users", ["creator"], name: "user_creator", using: :btree
  add_index "users", ["person_id"], name: "person_id_for_user", using: :btree
  add_index "users", ["retired_by"], name: "user_who_retired_this_user", using: :btree
  add_index "users", ["username"], name: "username_UNIQUE", unique: true, using: :btree

  create_table "vocabularies", force: :cascade do |t|
    t.string   "value",       limit: 255
    t.integer  "voided",      limit: 4
    t.string   "void_reason", limit: 255
    t.date     "date_voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", force: :cascade do |t|
    t.integer  "vocabulary_id", limit: 4
    t.string   "locale",        limit: 255
    t.string   "value",         limit: 255
    t.integer  "voided",        limit: 4
    t.string   "void_reason",   limit: 255
    t.date     "date_voided"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
