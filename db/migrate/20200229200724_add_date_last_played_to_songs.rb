class AddDateLastPlayedToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :date_last_played, :date, null: true
  end
end
