class CommentSerializer < Blueprinter::Base
  identifier :id

  fields :id, :content, :created_at, :updated_at
  association :user, blueprint: UserSerializer, view: :public
end
