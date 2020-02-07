class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.uuid  :reviewable_id, null: false
      t.string  :reviewable_type, null: false
      t.text :content, null: false
      t.string :status, null: false, default: 'draft'
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
    add_index :reviews, [:reviewable_type, :reviewable_id]
    add_index :reviews, [:user_id, :reviewable_type, :reviewable_id], unique: true
  end
end
