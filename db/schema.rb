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

ActiveRecord::Schema.define(version: 20160719144102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "g_game_board_tokens", force: :cascade do |t|
    t.integer  "g_game_board_id"
    t.integer  "q",               null: false
    t.integer  "r",               null: false
    t.integer  "top",             null: false
    t.integer  "left",            null: false
    t.string   "up_filename",     null: false
    t.string   "down_filename",   null: false
    t.string   "hover_data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["g_game_board_id"], name: "index_g_game_board_tokens_on_g_game_board_id", using: :btree
    t.index ["q", "r"], name: "index_g_game_board_tokens_on_q_and_r", unique: true, using: :btree
  end

  create_table "g_game_boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "g_game_board_tokens", "g_game_boards"
end
