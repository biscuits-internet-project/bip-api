class AddRelistenLinkToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :relisten_url, :string
  end
end
