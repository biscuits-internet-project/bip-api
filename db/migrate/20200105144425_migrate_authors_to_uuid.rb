class MigrateAuthorsToUuid < ActiveRecord::Migration[6.0]
  def up
    remove_column :authors, :id
    add_column :authors, :id, :uuid, default: "gen_random_uuid()", null: false
    execute "ALTER TABLE authors ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
