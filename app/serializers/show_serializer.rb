class ShowSerializer < Blueprinter::Base
  identifier :id

  fields :id, :slug, :venue_id, :notes, :likes_count, :youtube_id, :relisten_url
  field :date, datetime_format: "%Y-%m-%d"

  view :setlist do
    association :venue, blueprint: VenueSerializer
    association :tracks, blueprint: TrackSerializer, view: :setlist
  end
end
