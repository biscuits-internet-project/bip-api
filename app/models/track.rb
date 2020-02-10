class Track < ApplicationRecord
  extend FriendlyId
  include Likeable
  include Reviewable
  acts_as_taggable_on :track_tags

  friendly_id :build_slug, use: [:sequentially_slugged, :finders]

  belongs_to :song
  belongs_to :show
  has_many :annotations, dependent: :destroy
  has_one :venue, through: :show

  validates :song, :show, :position, :set, presence: true
  validates :slug, presence: true, uniqueness: true

  delegate :title, to: :song, prefix: true
  delegate :slug, to: :song, prefix: true

  def build_slug
    show.date_for_url + " " + song.slug
  end
end
