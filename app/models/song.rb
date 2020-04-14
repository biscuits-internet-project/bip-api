class Song < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:sequentially_slugged, :finders]

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  belongs_to :author, optional: true

  has_many :tracks, dependent: :destroy
  has_many :shows, through: :tracks

  delegate :name, to: :author, prefix: 'author', allow_nil: true

  after_touch :save
  after_save :update_stats, :expire_song_caches
  after_destroy :expire_song_caches

  # yearly play chart data for use with BarCharts from React Recharts library
  def yearly_play_chart_data
    self.yearly_play_data.map do |year, times_played|
      {name: year, plays: times_played}
    end
  end

  def expire_song_caches
    Rails.cache.delete('songs:all')
    Rails.cache.delete("songs:#{slug}")
    Rails.cache.delete("songs:#{id}")
  end

  def last_played_show
    shows.order("date asc").last
  end

  def shows_since_last_played
    Show.where(Show.arel_table[:date].gt(self.date_last_played)).count
  end

  def first_played_show
    shows.order("date asc").first
  end

  def update_times_played
    update_column(:times_played, shows.uniq.count)
  end

  def update_date_last_played
    update_column(:date_last_played, last_played_show&.date)
  end

  def update_stats

    self.update_columns(self.collect_stats)

  end

  def collect_stats
    {
      yearly_play_data: self.calculate_plays_by_year,
      most_common_year: self.calculate_most_common_year&.[](0),
      least_common_year: self.calculate_least_common_year&.[](0),
      longest_gaps_data: self.calculate_longest_gaps,
      date_last_played: self.last_played_show&.date,
      times_played: self.shows.uniq.count
    }
  end

  # returns a hash of { year => times_played }
  def calculate_plays_by_year
    # memoize the result as this is used as the basis for several other methods
    @plays_by_year ||= begin
      pby = self.tracks
                .joins(:show)
                .order(Arel.sql('EXTRACT(year FROM shows.date)::int'))
                .select('COUNT(DISTINCT(shows.id)) AS num_times_played, EXTRACT(year FROM shows.date)::int AS year')
                .group('EXTRACT(year FROM shows.date)::int')
                .map{ |x| [x.year, x.num_times_played]}
                .to_h
      # backfill all years since 1995 as query only returns records for years
      # with results
      (1995..Date.today.year).each do |y|
        pby[y] ||= 0
      end

      pby
    end
  end

  # returns an array of [year, times_played] for the year with the highest # of occurrences
  def calculate_most_common_year
    self.calculate_plays_by_year.sort_by{ |year, times_played| times_played }.last
  end

  # returns an array of [year, times_played] for the year with the lowest non-zero # of occurrences
  def calculate_least_common_year
    self.calculate_plays_by_year.select{ |year,times_played| times_played > 0 }.sort_by{ |year, times_played| times_played }.first
  end

  # returns a hash of the top N longest gaps, keyed by # of shows since previous occurence
  # { delta_shows => { date: <date of this show>, previous: <date of previous show>, delta_days: <days since previous show> } }
  def calculate_longest_gaps(top=5)
    tracks_with_deltas = Track.find_by_sql(sprintf('
      SELECT *, 
        (SELECT count(*) FROM (SELECT distinct(id) FROM shows WHERE date > subselect.previous_date AND date <= subselect.date) as subq1) as delta_shows
      FROM "tracks" 
      INNER JOIN (
        SELECT tracks.*, detailed_shows.* 
        FROM "tracks" 
        INNER JOIN (
          SELECT shows.id as show_id, shows.date as date, lag(shows.date, 1) OVER (ORDER BY shows.date) AS previous_date, shows.date - lag(shows.date, 1) OVER (ORDER BY shows.date) as delta_days 
          FROM "shows" 
          WHERE (id IN (SELECT shows.id FROM "tracks" INNER JOIN "shows" ON "shows"."id" = "tracks"."show_id" WHERE "tracks"."song_id" = \'%s\'))
        ) AS detailed_shows 
        ON detailed_shows.show_id = tracks.show_id 
        WHERE "tracks"."song_id" = \'%s\' 
        ORDER BY date
      ) as subselect ON subselect.id = tracks.id ORDER BY delta_shows DESC LIMIT %d;
    ', self.id, self.id, top))

    tracks_with_deltas.map { |t| [ t.delta_shows, { date: t.date, previous: t.previous_date, delta_days: t.delta_days } ] }.to_h
  end

  def generate_history_links

    return if history.blank?
    replacements = {}

    history.scan(/\d{1,2}\/\d{1,2}\/\d{2,4}/) do |match|
      date = Date.strptime(match, '%m/%d/%Y')
      show = Show.where(date: date.stamp("2001-01-30")).first
      if show.present?
        link = "<a href='/shows/#{show.slug}'>#{match}</a>"
        replacements[match] = link
      end
    end

    replacements.each do |k,v|
      history.gsub!(k, v)
    end
  end

end
