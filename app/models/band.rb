class Band < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, unique: true

  has_many :shows
end
