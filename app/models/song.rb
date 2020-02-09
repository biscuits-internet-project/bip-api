class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  belongs_to :author
  has_many :tracks, dependent: :destroy
  has_many :shows, through: :tracks

  delegate :name, to: :author, prefix: 'author', allow_nil: true

  after_save    :expire_song_all_cache, :expire_song_cache
  after_destroy :expire_song_all_cache, :expire_song_cache

  def expire_song_all_cache
    Rails.cache.delete('songs:all')
  end

  def expire_song_all_cache
    Rails.cache.delete("songs:#{slug}")
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

  def generate_history_links
    return if history.blank?
    replacements = {}

    history.scan(/\d*\/\d*\/\d*/) do |match|
      date = Date.strptime(match, '%m/%d/%Y')
      show = Show.where(date: date.stamp("2001-01-30")).first
      if show.present?
        link = "<a href='/shows/#{show.slug}'>#{match}</a>"
        replacements[match] = link
      end
    end

    replacements.each do |k,v|
      history.gsub!(k, v)
    end
  end

end
