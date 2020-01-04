class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name, nil: false
      t.string :slug, nil: false
      t.timestamps
    end

    add_index :authors, :slug
  end
end
