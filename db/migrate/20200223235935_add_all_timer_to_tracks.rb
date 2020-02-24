class AddAllTimerToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :tracks, :all_timer, :boolean, default: false
  end
end
