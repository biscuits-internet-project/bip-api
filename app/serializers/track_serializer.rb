class TrackSerializer < Blueprinter::Base
  identifier :id

  view :versions do
    fields :set, :position
    field :segue, default: ""
    association :venue, blueprint: VenueSerializer
    association :show, blueprint: ShowSerializer
    field :annotations do |track, options|
      track.annotations.map(&:desc)
    end
  end

  view :setlist do
    fields :set, :position, :song_id, :song_title, :song_slug
    field :segue, default: ""
    field :annotations do |track, options|
      track.annotations.map(&:desc)
    end
  end

end
