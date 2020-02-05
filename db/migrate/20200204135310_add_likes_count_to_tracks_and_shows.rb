class AddLikesCountToTracksAndShows < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :likes_count, :integer, null: false, default: 0
    add_column :shows, :likes_count, :integer, null: false, default: 0

    add_index :tracks, :likes_count
    add_index :shows, :likes_count
  end
end
