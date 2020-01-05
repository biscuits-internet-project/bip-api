class MigrateSongsToUuid < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE EXTENSION "uuid-ossp";'
    execute "ALTER TABLE songs DROP CONSTRAINT songs_pkey;"
    execute "ALTER TABLE songs ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE songs ALTER COLUMN id SET DATA TYPE UUID USING (uuid_generate_v4());"
    change_column :songs, :id, :uuid, default: "gen_random_uuid()", null: false
    remove_column :songs, :author_id
    add_column :songs, :author_id, :uuid
    execute "ALTER TABLE songs ADD PRIMARY KEY (id);"
  end
end
