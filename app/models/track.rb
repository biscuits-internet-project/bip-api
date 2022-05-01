class Track < ApplicationRecord
  extend FriendlyId
  include Likeable
  include Rateable

  acts_as_taggable

  friendly_id :slug_candidates, use: [:sequentially_slugged, :finders, :history]

  scope :setlist, -> { order("tracks.set in ('E1', 'E2'), tracks.set, tracks.position") }

  belongs_to :song, touch: true
  belongs_to :show
  belongs_to :previous_track, class_name: 'Track', optional: true
  belongs_to :next_track, class_name: 'Track', optional: true
  has_many :annotations, dependent: :destroy
  has_one :venue, through: :show

  validates :song, :show, :position, :set, presence: true
  validates :slug, presence: true

  delegate :title, to: :song, prefix: true
  delegate :slug, to: :song, prefix: true

  after_save :update_show_previous_and_next_tracks

  def slug_candidates
    [
      [show.date_for_url, song.slug, :set, :position]
    ]
  end

  def should_generate_new_friendly_id?
    song_id_changed? || show_id_changed?
  end

  def save_annotations(anns)
    annotations.destroy_all
    anns.compact.each do |ann|
      annotations << Annotation.new(desc: ann)
      tags = ["inverted", "unfinished", "ending only", "dub", "dyslexic"]
      tags.each do |tag|
        t = tag.gsub(" ", "-")
        if ann.downcase.include?(tag)
          tag_list.add(t)
        else
          tag_list.remove(t)
        end
      end
    end
    save
  end

  def update_show_previous_and_next_tracks
    self.show.tracks.each do |track|
      track.update_previous_and_next_tracks
    end
  end

  def update_previous_and_next_tracks
    previous_track_id = self.class.where(show_id: self.show_id, set: self.set, position: self.position.to_i - 1).limit(1).pluck(:id).first
    next_track_id = self.class.where(show_id: self.show_id, set: self.set, position: self.position.to_i + 1).limit(1).pluck(:id).first

    self.update_columns(previous_track_id: previous_track_id, next_track_id: next_track_id)
  end

end
