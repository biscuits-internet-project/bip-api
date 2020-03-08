class CreateMediaContents < ActiveRecord::Migration[6.0]
  def change
    create_table :media_contents, id: :uuid do |t|

      t.integer :year
      t.string :url
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
