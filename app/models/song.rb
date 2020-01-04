class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
end
