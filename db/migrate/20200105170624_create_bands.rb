class CreateBands < ActiveRecord::Migration[6.0]
  def change
    create_table :bands, id: :uuid do |t|
      t.string   "name"
      t.string   "slug"
      t.integer  "legacy_id"
      t.timestamps
    end
  end
end
