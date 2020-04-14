class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :author_name, :author_id, :times_played, :date_last_played

  view :details do
    fields :history, :featured_lyric, :notes, :lyrics, :tabs, 
      :shows_since_last_played, :yearly_play_chart_data, :most_common_year,
      :least_common_year, :longest_gaps_data
    association :first_played_show, blueprint: ShowSerializer
    association :last_played_show, blueprint: ShowSerializer
  end
end

