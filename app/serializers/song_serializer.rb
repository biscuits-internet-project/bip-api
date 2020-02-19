class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :author_name, :author_id, :times_played, :date_last_played

  view :details do
    fields :history, :featured_lyric, :notes, :lyrics, :tabs
    association :first_played_show, blueprint: ShowSerializer
    association :last_played_show, blueprint: ShowSerializer
  end
end

