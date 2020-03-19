class ReviewSerializer < Blueprinter::Base
  identifier :id

  fields :id, :content, :created_at, :updated_at
  association :user, blueprint: UserSerializer, view: :public

  field :show_id do |review, options|
    review.reviewable_id
  end
end
