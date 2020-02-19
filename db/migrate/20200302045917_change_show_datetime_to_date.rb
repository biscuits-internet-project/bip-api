class ChangeShowDatetimeToDate < ActiveRecord::Migration[6.0]
  def change
    change_column :shows, :date, :date, null: false
  end
end
