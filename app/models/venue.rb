class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :shows

  scope :city, -> (city, state) { where(city: city, state: state) }
  scope :state, -> (state) { where(state: state) }

  after_save    :expire_venue_all_cache
  after_destroy :expire_venue_all_cache

  def expire_venue_all_cache
    Rails.cache.delete('venues:all')
  end

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state],
    ]
  end

  def last_time_played
    shows.order("date asc").last&.date
  end

  def first_time_played
    shows.order("date asc").first&.date
  end

  def times_played
    shows.uniq.count
  end
end
