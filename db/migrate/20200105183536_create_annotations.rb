class CreateAnnotations < ActiveRecord::Migration[6.0]
  def change
    create_table :annotations, id: :uuid do |t|
      t.uuid "track_id", null: false
      t.text "desc"

      t.timestamps
    end
  end
end
