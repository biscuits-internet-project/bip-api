class AddReviewCountToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :show_reviews_count, :integer, null: false, default: 0
  end
end
