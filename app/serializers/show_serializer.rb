class ShowSerializer < Blueprinter::Base
  identifier :id

  fields :id, :slug, :venue_id, :notes, :likes_count, :relisten_url, :show_youtubes_count, :show_photos_count, :reviews_count, :average_rating
  field :date, datetime_format: "%Y-%m-%d"
  field :youtube_ids do |show, options|
    show.show_youtubes.map(&:video_id)
  end

  field :year do |show, options|
    show.date.year
  end

  association :venue, blueprint: VenueSerializer

  view :setlist do
    association :tracks, blueprint: TrackSerializer, view: :setlist
  end

  view :ratings do 
    field :ratings_count do |show, options|
      show.ratings.count
    end
  end

end
