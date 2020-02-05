class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances, id: :uuid do |t|

      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :show, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :attendances, [:user_id, :show_id], unique: true
  end

end
