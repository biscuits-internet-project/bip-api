class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts, id: :uuid do |t|

      t.text :title, null: false
      t.text :blurb, null: true
      t.text :slug, null: false
      t.text :content, null: true
      t.string :state, null: false, default: 'draft'
      t.datetime :published_at, null: true
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index "blog_posts", ["published_at"], name: "blog_posts_published_at_idx", using: :btree
    add_index "blog_posts", ["state"], name: "blog_posts_state_idx", using: :btree
    add_index "blog_posts", ["title"], name: "blog_posts_title_idx", using: :btree
  end
end
