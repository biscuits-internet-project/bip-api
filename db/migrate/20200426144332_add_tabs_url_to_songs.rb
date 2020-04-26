class AddTabsUrlToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :guitar_tabs_url, :text
  end
end
