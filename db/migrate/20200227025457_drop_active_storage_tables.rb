class DropActiveStorageTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :active_storage_blobs, force: :cascade
    drop_table :active_storage_attachments, force: :cascade
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
