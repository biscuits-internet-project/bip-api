class Author < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
  has_many :songs
end
