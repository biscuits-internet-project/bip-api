class AddAverageRatingToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :average_rating, :float, default: 0, nil: false
  end
end
