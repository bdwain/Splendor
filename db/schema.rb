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

ActiveRecord::Schema.define(version: 20140905231003) do

  create_table "cards", force: true do |t|
    t.integer "game_id",                        null: false
    t.integer "player_id"
    t.integer "position",       default: 0
    t.integer "level",          default: 1,     null: false
    t.integer "color",          default: 0,     null: false
    t.boolean "is_reserved",    default: false, null: false
    t.integer "victory_points", default: 0,     null: false
    t.integer "blue_cost",      default: 0,     null: false
    t.integer "red_cost",       default: 0,     null: false
    t.integer "green_cost",     default: 0,     null: false
    t.integer "black_cost",     default: 0,     null: false
    t.integer "white_cost",     default: 0,     null: false
  end

  create_table "games", force: true do |t|
    t.integer  "num_players",             null: false
    t.integer  "status",      default: 1, null: false
    t.integer  "creator_id",              null: false
    t.integer  "winner_id"
    t.integer  "blue_chips",  default: 0, null: false
    t.integer  "red_chips",   default: 0, null: false
    t.integer  "green_chips", default: 0, null: false
    t.integer  "black_chips", default: 0, null: false
    t.integer  "white_chips", default: 0, null: false
    t.integer  "gold_chips",  default: 0, null: false
    t.integer  "turn_num",    default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["creator_id"], name: "index_games_on_creator_id", using: :btree
  add_index "games", ["winner_id"], name: "index_games_on_winner_id", using: :btree

  create_table "nobles", force: true do |t|
    t.integer "game_id",                     null: false
    t.integer "player_id"
    t.integer "blue_card_cost",  default: 0, null: false
    t.integer "red_card_cost",   default: 0, null: false
    t.integer "green_card_cost", default: 0, null: false
    t.integer "black_card_cost", default: 0, null: false
    t.integer "white_card_cost", default: 0, null: false
  end

  create_table "players", force: true do |t|
    t.integer  "game_id",                   null: false
    t.integer  "user_id",                   null: false
    t.integer  "turn_num",      default: 1, null: false
    t.integer  "turn_status",   default: 0, null: false
    t.datetime "turn_deadline"
    t.integer  "blue_chips",    default: 0, null: false
    t.integer  "red_chips",     default: 0, null: false
    t.integer  "green_chips",   default: 0, null: false
    t.integer  "black_chips",   default: 0, null: false
    t.integer  "white_chips",   default: 0, null: false
    t.integer  "gold_chips",    default: 0, null: false
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree
  add_index "players", ["user_id", "game_id"], name: "index_players_on_user_id_and_game_id", unique: true, using: :btree
  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "displayname",            limit: 20,              null: false
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
