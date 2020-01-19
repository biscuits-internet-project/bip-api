class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
  validates :slug, unique: true

  belongs_to :author

  delegate :name, to: :author, prefix: 'author', allow_nil: true
end
