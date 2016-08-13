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

ActiveRecord::Schema.define(version: 20160813192753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listeners", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.string   "passcode"
    t.integer  "request_limit"
    t.integer  "flag_minimum"
    t.boolean  "allow_explicit"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "playlistsongs", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.date     "release_date"
    t.string   "album_art"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "spotify_credentials"
    t.string   "spotify_access_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "library_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
