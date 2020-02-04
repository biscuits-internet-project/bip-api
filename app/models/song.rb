class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  belongs_to :author
  has_many :tracks
  has_many :shows, through: :tracks

  delegate :name, to: :author, prefix: 'author', allow_nil: true

  after_save    :expire_song_all_cache
  after_destroy :expire_song_all_cache

  def expire_song_all_cache
    Rails.cache.delete('Song.all')
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
