class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true

  has_many :shows

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state],
    ]
  end
end
