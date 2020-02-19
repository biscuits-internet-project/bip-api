class RemoveYoutubeIdFromShows < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :youtube_id
  end
end
