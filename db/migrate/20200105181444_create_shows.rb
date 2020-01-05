class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows, id: :uuid do |t|
      t.string   "slug"
      t.datetime "date"
      t.uuid     "venue_id"
      t.uuid     "band_id"
      t.text     "notes"
      t.integer  "legacy_id"
      t.timestamps
    end
  end
end
