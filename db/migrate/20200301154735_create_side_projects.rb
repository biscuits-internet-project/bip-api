class CreateSideProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :side_projects, id: :uuid do |t|
      t.string :name
      t.string :dates
      t.text :notes
      t.string :mem1
      t.string :mem2
      t.string :mem3
      t.string :mem4
      t.string :mem5
      t.string :mem6
      t.string :mem7

      t.timestamps
    end
  end
end
