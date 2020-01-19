class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :shows

  scope :city, -> (city, state) { where(city: city, state: state) }
  scope :state, -> (state) { where(state: state) }

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state],
    ]
  end
end
