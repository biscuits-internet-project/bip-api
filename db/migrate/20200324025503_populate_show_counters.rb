class PopulateShowCounters < ActiveRecord::Migration[6.0]
  def up
    Show.find_each do |show|
      Show.reset_counters(show.id, :show_photos)
      Show.reset_counters(show.id, :show_youtubes)
    end
  end
end
