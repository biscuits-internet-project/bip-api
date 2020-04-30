class DropShowsFromRatings < ActiveRecord::Migration[6.0]
  def change
    remove_column :ratings, :show_id
  end
end
