class Show < ApplicationRecord
  include PgSearch::Model
  multisearchable :against => [:date, :date_month, :venue_name, :venue_city, :venue_country, :date_for_search,
   :venue_state_name, :venue_state, :notes, :song_titles, :has_photos, :has_youtube, :has_relisten]

  extend FriendlyId
  include Likeable
  include Reviewable

  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  delegate :name, :city, :state, :state_name, :country, to: :venue, prefix: 'venue', allow_nil: true

  belongs_to :venue, touch: true
  belongs_to :band
  has_many :tracks, dependent: :destroy
  has_many :show_photos, dependent: :destroy
  has_many :show_youtubes, dependent: :destroy
  validates :venue, :slug, :band, presence: true
  validates :slug, uniqueness: true

  def slug_candidates
    [
      [:date_for_url, :venue_name, :venue_city, :venue_state]
    ]
  end

  def song_titles
    tracks.includes(:song).map { |t| t.song.title }.uniq.join(" ")
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

  def date_month
    date.strftime("%B")
  end

  def date_for_search
    date.stamp("1/29/2015")
  end

  def self.by_year(year)
    dt = DateTime.new(year)
    boy = dt.beginning_of_year
    eoy = dt.end_of_year
    where("date >= ? and date <= ?", boy, eoy)
  end

  def date_for_url
    if date
      date.stamp('2015 01 29')
    else
      'unknown'
    end
  end
end

