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

ActiveRecord::Schema.define(version: 20140324153902) do

  create_table "acts", force: true do |t|
    t.integer  "user_id"
    t.integer  "battle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  create_table "battle_connections", id: false, force: true do |t|
    t.integer "battle_id"
    t.integer "postbattle_id"
  end

  create_table "battles", force: true do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setups", force: true do |t|
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "start"
    t.text     "show"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.integer  "event_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setup_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

end
