class TrackSerializer < Blueprinter::Base
  identifier :id

  fields :set, :position, :note, :slug, :song_id, :all_timer
  field :segue, default: ""
  field :annotations do |track, options|
    track.annotations.map(&:desc)
  end

  view :versions do
    field :track_tags, name: :tags do |track, options|
      track.track_tags.map(&:name)
    end
    association :venue, blueprint: VenueSerializer
    association :show, blueprint: ShowSerializer
  end

  view :setlist do
    fields :song_title, :song_slug
  end

end
