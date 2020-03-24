class AddCountersToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :show_photos_count, :integer, null: false, default: 0
    add_column :shows, :show_youtubes_count, :integer, null: false, default: 0
  end
end
