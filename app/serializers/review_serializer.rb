class ReviewSerializer < Blueprinter::Base
  identifier :id

  fields :id, :content, :created_at, :updated_at, :show_id
  association :user, blueprint: UserSerializer, view: :public
end
