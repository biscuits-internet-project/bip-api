class Show < ApplicationRecord
  include PgSearch::Model
  multisearchable :against => [:venue_name, :venue_city, :venue_country, :dates_for_search,
    :venue_state_name, :venue_state, :notes, :song_titles, :has_photos, :has_youtube, :has_relisten, :track_annotations, :has_reviews]

  extend FriendlyId
  include Likeable
  include Rateable

  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  delegate :name, :city, :state, :state_name, :country, to: :venue, prefix: 'venue', allow_nil: true

  belongs_to :venue, touch: true
  belongs_to :band
  has_many :tracks, dependent: :destroy
  has_many :annotations, through: :tracks
  has_many :show_photos, dependent: :destroy
  has_many :show_youtubes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :venue, :slug, :band, presence: true
  validates :slug, uniqueness: true

  def slug_candidates
    [
      [:date_for_url, :venue_name, :venue_city, :venue_state]
    ]
  end

  def song_titles
    tracks.order(:position).includes(:song).map do |t|
      if t.segue.present?
        t.song.title + " " + t.segue
      else
        t.song.title
      end
    end.uniq.join(" ")
  end

  def has_photos
    return "photos" if show_photos.exists?
  end

  def has_youtube
    return "youtube" if show_youtubes.exists?
  end

  def has_relisten
    return "relisten" if relisten_url.present?
  end

  def has_reviews
    return "reviews review" if reviews.exists?
  end

  def dates_for_search
    date.strftime("%-m/%-d") + " " +
    date.strftime("%-m/%-d/%Y") + " " +
    date.strftime("%-m/%-d/%y") + " " +
    date.strftime("%Y") + " " +
    date.strftime("%B")
  end

  def track_annotations
    annotations.map(&:desc).join(" ")
  end

  def self.by_year(year)
    dt = DateTime.new(year)
    boy = dt.beginning_of_year
    eoy = dt.end_of_year
    where("date >= ? and date <= ?", boy, eoy)
  end

  def self.by_day_of_year(month, day)
    where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(DAY FROM date) = ?", month, day)
  end

  def shows_on_same_day
    self.class.by_day_of_year(self.date.month, self.date.day).where.not(id: self.id).order(:date)
  end

  def date_for_url
    if date
      date.stamp('2015 01 29')
    else
      'unknown'
    end
  end
end

