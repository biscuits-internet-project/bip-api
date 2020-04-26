namespace :songs do
  task :stats => [:environment] do

    Song.includes(:shows).each(&:update_stats)

  end

  task :guitar_tabs => [:environment] do

    songs = Song.where.not(times_played: 0).to_a

    songs.each do |song|

      slug = song.title.gsub("'", "").parameterize.underscore.dasherize

      url = "http://sickbarberlicks.weebly.com/#{slug}.html"
      response = HTTParty.get(url)

      if response.code == 200
        #puts "+ " + song.title
        song.update_attribute(:guitar_tabs_url, url)
      else
        if song.times_played > 1 && !song.cover
          puts "- " + song.slug
        end
      end
    end
  end
end