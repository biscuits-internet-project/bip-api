# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_09_085036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "annotations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "track_id", null: false
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "authors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_authors_on_slug"
  end

  create_table "bands", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "legacy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "legacy_shows", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.integer "band"
    t.date "date"
    t.integer "venue", default: 0, null: false
    t.text "set1"
    t.text "set2"
    t.text "set3"
    t.text "set4"
    t.text "encore1"
    t.text "encore2"
    t.text "precomment"
    t.text "comment1"
    t.text "comment2"
    t.text "comment3"
    t.text "comment4"
    t.text "comment5"
    t.text "comment6"
    t.text "comment7"
    t.text "comment8"
    t.text "comment9"
    t.text "comment10"
    t.text "sources"
    t.text "flips"
    t.integer "showorder"
    t.text "reviews"
    t.string "archiveorg", limit: 300
  end

  create_table "shows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.datetime "date"
    t.uuid "venue_id"
    t.uuid "band_id"
    t.text "notes"
    t.integer "legacy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "lyrics"
    t.text "tabs"
    t.text "notes"
    t.string "legacy_abbr"
    t.integer "legacy_id"
    t.boolean "cover", default: false
    t.uuid "author_id"
    t.text "legacy_author"
  end

  create_table "tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "show_id", null: false
    t.uuid "song_id", null: false
    t.string "set", null: false
    t.integer "position", null: false
    t.string "segue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "venues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.float "latitude"
    t.float "longitude"
    t.string "phone"
    t.string "website"
    t.integer "legacy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
