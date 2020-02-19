class Show < ApplicationRecord
  include PgSearch::Model
  multisearchable :against => [:date, :date_month, :venue_name, :venue_city, :notes]

  extend FriendlyId
  include Likeable
  include Reviewable

  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  delegate :name, :city, :state, to: :venue, prefix: 'venue', allow_nil: true

  belongs_to :venue, touch: true
  belongs_to :band
  has_many :tracks, dependent: :destroy
  has_many :show_photos, dependent: :destroy
  validates :venue, :slug, :band, presence: true
  validates :slug, uniqueness: true

  def slug_candidates
    [
      [:date_for_url, :venue_name, :venue_city, :venue_state]
    ]
  end

  def date_month
    date.strftime("%B")
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

