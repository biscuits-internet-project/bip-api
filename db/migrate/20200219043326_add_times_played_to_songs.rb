class AddTimesPlayedToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :times_played, :integer, default: 0, null: false
  end
end
