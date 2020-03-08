class AddMediaTypeToMediaContents < ActiveRecord::Migration[6.0]
  def change
    add_column :media_contents, :media_type, :string, null: false
  end
end
