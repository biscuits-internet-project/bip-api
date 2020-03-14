class Track < ApplicationRecord
  extend FriendlyId
  include Likeable
  include Reviewable
  acts_as_taggable_on :track_tags

  friendly_id :build_slug, use: [:sequentially_slugged, :finders, :history]

  scope :setlist, -> { order("tracks.set in ('E1', 'E2'), tracks.set, tracks.position") }

  belongs_to :song, touch: true
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

  def should_generate_new_friendly_id?
    song_id_changed? || show_id_changed?
  end

  def save_annotations(anns)
    return if anns.blank?
    annotations.destroy_all
    anns.compact.each do |ann|
      annotations << Annotation.new(desc: ann)
    end
  end
end
