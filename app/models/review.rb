class Review < ApplicationRecord
  include Likeable
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :reviewable, :user, :content, presence: true

end
