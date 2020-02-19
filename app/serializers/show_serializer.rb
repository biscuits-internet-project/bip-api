class ShowSerializer < Blueprinter::Base
  identifier :id

  fields :id, :slug, :venue_id, :notes, :likes_count, :relisten_url
  field :date, datetime_format: "%Y-%m-%d"
  field :youtube_ids do |show, options|
    show.show_youtubes.map(&:video_id)
  end

  association :venue, blueprint: VenueSerializer

  view :setlist do
    association :tracks, blueprint: TrackSerializer, view: :setlist
  end
end
