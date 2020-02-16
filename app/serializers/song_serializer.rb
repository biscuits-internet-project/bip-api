class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :author_name, :author_id

  view :details do
    fields :times_played, :history, :featured_lyric, :notes, :lyrics, :tabs
    association :first_played_show, blueprint: ShowSerializer
    association :last_played_show, blueprint: ShowSerializer
  end
end

