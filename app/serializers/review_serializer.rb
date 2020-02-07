class ReviewSerializer < Blueprinter::Base
  identifier :id

  fields :id, :content, :reviewable_type, :reviewable_id
  association :user, blueprint: UserSerializer, view: :public
end
