class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks, id: :uuid do |t|
      t.uuid  "show_id", null: false
      t.uuid  "song_id", null: false
      t.string   "set", null: false
      t.integer  "position", null: false
      t.string  "segue"
      t.timestamps
    end
  end
end
