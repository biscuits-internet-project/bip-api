class BlogPostSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :blurb, :content, :state, :published_at,
   :primary_image_url, :secondary_image_url, :created_at, :updated_at
  association :user, blueprint: UserSerializer, view: :public
  field :tag_list, name: :tags do |track, options|
    track.tags.map(&:name)
  end

  view :full do
    field :content
    association :comments, blueprint: CommentSerializer
  end
end

