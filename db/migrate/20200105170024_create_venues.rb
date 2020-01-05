class CreateVenues < ActiveRecord::Migration[6.0]
  def change

    create_table :venues, id: :uuid do |t|
      t.string   "name"
      t.string   "slug"
      t.string   "street"
      t.string   "city"
      t.string   "state"
      t.string   "country"
      t.string   "postal_code"
      t.float    "latitude"
      t.float    "longitude"
      t.string   "phone"
      t.string   "website"
      t.integer  "legacy_id"
      t.timestamps
    end

    add_index "venues", ["slug"], name: "index_venues_on_slug", using: :btree
  end
end
