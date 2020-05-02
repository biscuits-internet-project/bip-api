class ChangeRatingsToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :ratings, :value, :float, null: false, default: 0
  end
end
