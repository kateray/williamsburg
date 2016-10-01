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

ActiveRecord::Schema.define(version: 20161001193317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_pins", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "neighborhood"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "neighborhood"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "country"
    t.string   "state"
  end

  create_table "user_pins", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "neighborhood"
    t.string   "token"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "country"
    t.string   "state"
    t.string   "city_name"
    t.string   "suburb"
    t.string   "town"
    t.string   "used_city"
    t.string   "used_neighborhood"
    t.string   "quat_city"
    t.string   "quat_neighborhood"
    t.string   "override_neighborhood"
    t.string   "country_code"
  end

end
