class Likes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes, id: :uuid do |t|
      t.uuid  :likeable_id, null: false
      t.string  :likeable_type, null: false
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
 
    add_index :likes, [:likeable_type, :likeable_id]
    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true

  end
end
