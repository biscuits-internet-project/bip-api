class TrackSerializer < Blueprinter::Base
  identifier :id

  fields :set, :position, :note, :slug, :song_id
  field :segue, default: ""

  view :versions do
    association :venue, blueprint: VenueSerializer
    association :show, blueprint: ShowSerializer
    field :annotations do |track, options|
      track.annotations.map(&:desc)
    end
  end

  view :setlist do
    fields :song_title, :song_slug
    field :annotations do |track, options|
      track.annotations.map(&:desc)
    end
  end

end
