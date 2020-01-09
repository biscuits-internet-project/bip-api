namespace :tracks do
  task :build => [:environment] do
    shows = Show.all.to_a
    legacy_shows = LegacyShow.order(:id).limit(10).to_a

    legacy_shows.each do |ls|

      show = shows.select { |s| s.legacy_id == ls.id }
      if show.nil?
        raise "can't find show for legacy id #{ls.id}"
      end

      puts show

    end
  end
end