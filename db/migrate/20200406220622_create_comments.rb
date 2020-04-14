class CreateComments < ActiveRecord::Migration[6.0]
  def change

    create_table :comments, id: :uuid do |t|
      t.uuid  :commentable_id, null: false
      t.string  :commentable_type, null: false
      t.text :content, null: false
      t.string :status, null: false, default: 'published'
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
