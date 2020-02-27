class AddShowPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :show_photos, id: :uuid do |t|
      t.string :label, null: true
      t.string :source, null: true
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :show, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
