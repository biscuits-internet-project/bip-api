class AddTimesPlayedToVenues < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :times_played, :integer, default: 0, null: false
  end
end
