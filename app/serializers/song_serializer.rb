class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :author_name, :author_id

  view :details do
    fields :times_played, :history, :featured_lyric, :notes, :lyrics, :tabs
    field :first_time_played, datetime_format: "%Y-%m-%d"
    field :last_time_played, datetime_format: "%Y-%m-%d"
  end
end

