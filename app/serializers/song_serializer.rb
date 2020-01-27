class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :notes, :lyrics, :tabs, :author_name, :author_id
  
  view :details do
    field :times_played
    field :first_time_played, datetime_format: "%Y-%m-%d"
    field :last_time_played, datetime_format: "%Y-%m-%d"
  end
end

