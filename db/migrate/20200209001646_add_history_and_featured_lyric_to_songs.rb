class AddHistoryAndFeaturedLyricToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :history, :text
    add_column :songs, :featured_lyric, :text
  end
end
