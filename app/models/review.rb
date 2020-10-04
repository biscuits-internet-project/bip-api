class Review < ApplicationRecord
  include Likeable
  belongs_to :show, counter_cache: true
  belongs_to :user

  validates :show, :user, :content, presence: true

end
