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

ActiveRecord::Schema.define(version: 20140312153704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", id: false, force: true do |t|
    t.integer "meetup_profile_id", null: false
    t.integer "event_id",          null: false
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id", using: :btree
  add_index "attendances", ["meetup_profile_id", "event_id"], name: "index_attendances_on_meetup_profile_id_and_event_id", unique: true, using: :btree
  add_index "attendances", ["meetup_profile_id"], name: "index_attendances_on_meetup_profile_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "group_name"
    t.string   "venue_name"
    t.datetime "time"
    t.string   "meetup_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meetup_id"
  end

  create_table "meetup_profiles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "photo_url"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "access_expiration"
    t.string   "other_services"
  end

  create_table "notes", force: true do |t|
    t.integer  "owner_id"
    t.integer  "about_id"
    t.text     "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["owner_id", "about_id"], name: "index_notes_on_owner_id_and_about_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meetup_profile_id",                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end