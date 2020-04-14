class AddStatsToSongs < ActiveRecord::Migration[6.0]
  def change

    add_column :songs, :yearly_play_data, :jsonb, :null => false, :default => {}
    add_index  :songs, :yearly_play_data, :using => :gin
    add_column :songs, :longest_gaps_data, :jsonb, :null => false, :default => {}
    add_index  :songs, :longest_gaps_data, :using => :gin
    add_column :songs, :most_common_year, :integer
    add_column :songs, :least_common_year, :integer

    add_column :tracks, :previous_track_id, :uuid
    add_index :tracks,  :previous_track_id
    add_column :tracks, :next_track_id, :uuid
    add_index :tracks,  :next_track_id

  end
end
