class ShowSerializer < Blueprinter::Base
  identifier :id

  view :normal do
    fields :id, :slug, :venue_id, :notes
    field :date, datetime_format: "%Y-%m-%d" 
  end

  view :setlist do
    include_view :normal
    association :venue, blueprint: VenueSerializer
    association :tracks, blueprint: TrackSerializer, view: :setlist
  end
end
