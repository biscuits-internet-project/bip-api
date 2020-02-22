class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :shows

  scope :city, -> (city, state) { where(city: city, state: state) }
  scope :state, -> (state) { where(state: state) }

  after_save :update_times_played, :expire_venue_all_cache
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

  def last_played_show
    shows.order("date asc").last
  end

  def first_played_show
    shows.order("date asc").first
  end

  def update_times_played
    update_column(:times_played, shows.count)
  end
end
