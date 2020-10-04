class ChangeShowReviewsToReviewsOnShows < ActiveRecord::Migration[6.0]
  def change
    rename_column :shows, :show_reviews_count, :reviews_count
  end
end
