class CreateShowYoutubes < ActiveRecord::Migration[6.0]
  def change
    create_table :show_youtubes, id: :uuid do |t|

      t.references :show, type: :uuid, index: true, null: false, foreign_key: true
      t.string :video_id, null: false

      t.timestamps
    end
  end
end
