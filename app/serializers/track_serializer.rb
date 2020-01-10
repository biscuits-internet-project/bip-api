class TrackSerializer < Blueprinter::Base
  #identifier :id

  view :setlist do
    fields :set, :position, :segue, :song_id, :song_title, :song_slug
    field :annotations do |track, options|
      track.annotations.map(&:desc)
    end
  end

end
