class PolymorphicRatings < ActiveRecord::Migration[6.0]
  def up
    change_table :ratings do |t|
      t.references :rateable, polymorphic: true, type: :uuid
    end
  end

  def down
    change_table :ratings do |t|
      t.remove_references :rateable, polymorphic: true
    end
  end
end
