class Author < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :sequentially_slugged

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
  has_many :songs
end
