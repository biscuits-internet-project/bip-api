class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders]

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :shows

  scope :city, -> (city, state) { where(city: city, state: state) }
  scope :state, -> (state) { where(state: state) }

  after_touch :save
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

  def state_name
    state_name_to_abbr.invert[state]
  end

  private

  def state_name_to_abbr
    {
        "Alabama" => "AL",
        "Alaska" => "AK",
        "Arizona" => "AZ",
        "Arkansas" => "AR",
        "California" => "CA",
        "Colorado" => "CO",
        "Connecticut" => "CT",
        "Delaware" => "DE",
        "Florida" => "FL",
        "Georgia" => "GA",
        "Hawaii" => "HI",
        "Idaho" => "ID",
        "Illinois" => "IL",
        "Indiana" => "IN",
        "Iowa" => "IA",
        "Kansas" => "KS",
        "Kentucky" => "KY",
        "Louisiana" => "LA",
        "Maine" => "ME",
        "Maryland" => "MD",
        "Massachusetts" => "MA",
        "Michigan" => "MI",
        "Minnesota" => "MN",
        "Mississippi" => "MS",
        "Missouri" => "MO",
        "Montana" => "MT",
        "Nebraska" => "NE",
        "Nevada" => "NV",
        "New Hampshire" => "NH",
        "New Jersey" => "NJ",
        "New Mexico" => "NM",
        "New York" => "NY",
        "North Carolina" => "NC",
        "North Dakota" => "ND",
        "Ohio" => "OH",
        "Oklahoma" => "OK",
        "Oregon" => "OR",
        "Pennsylvania" => "PA",
        "Rhode Island" => "RI",
        "South Carolina" => "SC",
        "South Dakota" => "SD",
        "Tennessee" => "TN",
        "Texas" => "TX",
        "Utah" => "UT",
        "Vermont" => "VT",
        "Virginia" => "VA",
        "Washington" => "WA",
        "West Virginia" => "WV",
        "Wisconsin" => "WI",
        "Wyoming" => "WY",
        "British Columbia" => "BC",
        "Ontario" => "ON"
      }
    end
end
