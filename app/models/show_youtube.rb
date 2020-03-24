class ShowYoutube < ApplicationRecord
  validates :show, :video_id, presence: true
  belongs_to :show, counter_cache: true
end
