class AddYoutubeIdToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :youtube_id, :string
  end
end
