class AddContraintsToDatabase < ActiveRecord::Migration[6.0]
  def change
    change_column_null :authors, :slug, false
    change_column_null :bands, :slug, false
    change_column_null :shows, :slug, false
    change_column_null :songs, :slug, false
    change_column_null :venues, :slug, false

    add_foreign_key :annotations, :tracks
    add_foreign_key :shows, :venues
    add_foreign_key :shows, :bands
    add_foreign_key :songs, :authors
    add_foreign_key :tracks, :shows
    add_foreign_key :tracks, :songs
  end
end
