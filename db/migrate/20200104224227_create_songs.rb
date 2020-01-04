class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table "songs" do |t|
      t.integer  "author_id"
      t.string   "title", null: false
      t.string   "slug", null: false
      t.datetime "created_at",                  null: false
      t.datetime "updated_at",                  null: false
      t.text     "lyrics"
      t.text     "tabs"
      t.text     "notes"
      t.string   "legacy_abbr"
      t.integer  "legacy_id"
      t.boolean  "cover",       default: false
    end
  end
end
