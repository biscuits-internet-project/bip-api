class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings, id: :uuid do |t|

      t.integer :value, null: false
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :show, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
