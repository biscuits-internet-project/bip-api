class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  belongs_to :author
  has_many :tracks, dependent: :destroy
  has_many :shows, through: :tracks

  delegate :name, to: :author, prefix: 'author', allow_nil: true

  after_touch :save
  after_save :update_times_played, :expire_song_caches, :update_date_last_played
  after_destroy :expire_song_caches

  def expire_song_caches
    Rails.cache.delete('songs:all')
    Rails.cache.delete("songs:#{slug}")
    Rails.cache.delete("songs:#{id}")
  end

  def last_played_show
    shows.order("date asc").last
  end

  def shows_since_last_played
    Show.where(Show.arel_table[:date].gt(self.date_last_played)).count
  end

  def first_played_show
    shows.order("date asc").first
  end

  def update_times_played
    update_column(:times_played, shows.uniq.count)
  end

  def update_date_last_played
    update_column(:date_last_played, last_played_show&.date)
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
