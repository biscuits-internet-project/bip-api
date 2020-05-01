class TrackSerializer < Blueprinter::Base
  identifier :id

  fields :set, :position, :note, :slug, :song_id, :all_timer, :annotations, :average_rating
  field :segue, default: ""
  field :annotations do |track, options|
    track.annotations.map(&:desc)
  end

  view :versions do
    field :tags, name: :tags do |track, options|
      track.tags.map(&:name)
    end
    association :venue, blueprint: VenueSerializer
    association :show, blueprint: ShowSerializer
    association :previous_track, blueprint: TrackSerializer
    association :next_track, blueprint: TrackSerializer
  end

  view :charts do
    association :song, blueprint: SongSerializer
    association :show, blueprint: ShowSerializer
  end

  view :setlist do
    fields :song_title, :song_slug
  end

end
