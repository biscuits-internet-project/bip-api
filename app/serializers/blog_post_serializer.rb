class BlogPostSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :blurb, :content, :state, :published_at, :tag_list
  association :user, blueprint: UserSerializer, view: :public

  view :full do
    field :content
    association :comments, blueprint: CommentSerializer
  end
end

