class AddLegacyAuthorToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :legacy_author, :text
  end
end
