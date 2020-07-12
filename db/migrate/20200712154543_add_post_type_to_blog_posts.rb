class AddPostTypeToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :post_type, :string, null: false, default: 'blog'
  end
end
