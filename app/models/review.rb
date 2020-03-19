class Review < ApplicationRecord
  include Likeable
  belongs_to :show
  belongs_to :user

  validates :show, :user, :content, presence: true

end
