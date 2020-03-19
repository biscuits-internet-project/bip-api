class BlogPostSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :blurb, :content, :state, :published_at
  association :user, blueprint: UserSerializer, view: :public

  view :full do
    field :content
  end
end

