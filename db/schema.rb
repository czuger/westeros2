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

ActiveRecord::Schema.define(version: 2016_07_24_181428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "al_alliance_masters", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.integer "h_house_id", null: false
    t.integer "h_house_master_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id", "h_house_id"], name: "index_al_alliance_masters_on_g_game_board_id_and_h_house_id", unique: true
    t.index ["g_game_board_id"], name: "index_al_alliance_masters_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_al_alliance_masters_on_h_house_id"
    t.index ["h_house_master_id"], name: "index_al_alliance_masters_on_h_house_master_id"
  end

  create_table "al_bets", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.integer "h_house_id", null: false
    t.integer "h_target_house_id", null: false
    t.integer "bet", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id", "h_house_id", "h_target_house_id"], name: "al_bets_unique_index", unique: true
    t.index ["g_game_board_id"], name: "index_al_bets_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_al_bets_on_h_house_id"
    t.index ["h_target_house_id"], name: "index_al_bets_on_h_target_house_id"
  end

  create_table "al_houses", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.integer "h_house_id", null: false
    t.boolean "minor_alliance_member", default: true
    t.integer "last_bet", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id", "h_house_id"], name: "al_houses_unique_index", unique: true
    t.index ["g_game_board_id"], name: "index_al_houses_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_al_houses_on_h_house_id"
  end

  create_table "al_logs", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.integer "log_code", null: false
    t.text "alliance_details"
    t.integer "turn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id"], name: "index_al_logs_on_g_game_board_id"
  end

  create_table "al_relationships", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.integer "h_house_id", null: false
    t.integer "h_peer_house_id", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id", "h_house_id", "h_peer_house_id"], name: "al_relationships_unique_index", unique: true
    t.index ["g_game_board_id"], name: "index_al_relationships_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_al_relationships_on_h_house_id"
    t.index ["h_peer_house_id"], name: "index_al_relationships_on_h_peer_house_id"
    t.index ["type"], name: "index_al_relationships_on_type"
  end

  create_table "c_cities", id: :serial, force: :cascade do |t|
    t.string "code_name"
    t.integer "q"
    t.integer "r"
    t.integer "h_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["h_house_id"], name: "index_c_cities_on_h_house_id"
    t.index ["q", "r"], name: "index_c_cities_on_q_and_r", unique: true
  end

  create_table "g_armies", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id"
    t.integer "h_house_id"
    t.string "type"
    t.string "code_name"
    t.integer "q"
    t.integer "r"
    t.integer "nb_banners"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id", "q", "r"], name: "index_g_armies_on_g_game_board_id_and_q_and_r", unique: true
    t.index ["g_game_board_id"], name: "index_g_armies_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_g_armies_on_h_house_id"
    t.index ["type"], name: "index_g_armies_on_type"
  end

  create_table "g_game_board_players", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id"], name: "index_g_game_board_players_on_g_game_board_id"
  end

  create_table "g_game_board_tokens", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id"
    t.integer "q", null: false
    t.integer "r", null: false
    t.integer "top", null: false
    t.integer "left", null: false
    t.string "up_filename", null: false
    t.string "down_filename", null: false
    t.string "hover_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "extra_parameters"
    t.index ["g_game_board_id"], name: "index_g_game_board_tokens_on_g_game_board_id"
  end

  create_table "g_game_boards", id: :serial, force: :cascade do |t|
    t.integer "turn", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_houses", id: :serial, force: :cascade do |t|
    t.integer "g_game_board_id"
    t.integer "h_house_id"
    t.boolean "major_house", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_game_board_id"], name: "index_g_houses_on_g_game_board_id"
    t.index ["h_house_id"], name: "index_g_houses_on_h_house_id"
  end

  create_table "h_houses", id: :serial, force: :cascade do |t|
    t.string "code_name", null: false
    t.integer "h_suzerain_house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_name"], name: "index_h_houses_on_code_name", unique: true
    t.index ["h_suzerain_house_id"], name: "index_h_houses_on_h_suzerain_house_id"
  end

  add_foreign_key "al_alliance_masters", "g_game_boards"
  add_foreign_key "al_alliance_masters", "h_houses"
  add_foreign_key "al_alliance_masters", "h_houses", column: "h_house_master_id"
  add_foreign_key "al_bets", "g_game_boards"
  add_foreign_key "al_bets", "h_houses"
  add_foreign_key "al_bets", "h_houses", column: "h_target_house_id"
  add_foreign_key "al_houses", "g_game_boards"
  add_foreign_key "al_houses", "h_houses"
  add_foreign_key "al_logs", "g_game_boards"
  add_foreign_key "al_relationships", "g_game_boards"
  add_foreign_key "al_relationships", "h_houses"
  add_foreign_key "al_relationships", "h_houses", column: "h_peer_house_id"
  add_foreign_key "c_cities", "h_houses"
  add_foreign_key "g_armies", "g_game_boards"
  add_foreign_key "g_armies", "h_houses"
  add_foreign_key "g_game_board_players", "g_game_boards"
  add_foreign_key "g_game_board_tokens", "g_game_boards"
  add_foreign_key "g_houses", "g_game_boards"
  add_foreign_key "g_houses", "h_houses"
  add_foreign_key "h_houses", "h_houses", column: "h_suzerain_house_id"
end
