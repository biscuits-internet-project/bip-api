class AddDbConstraints < ActiveRecord::Migration[6.0]
  def change
    add_index :bands, :slug, unique: true
    add_index :shows, :slug, unique: true
    add_index :songs, :slug, unique: true
  end
end
