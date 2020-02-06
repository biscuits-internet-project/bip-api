namespace :shows do
  task :relisten => [:environment] do

    shows = Show.order(:date).to_a
    shows.each_with_index do |show, i|
      url = "https://relisten.net/disco-biscuits/#{show.date.stamp('2009/01/16')}"

      response = HTTParty.get(url)

      if response.code == 200
        show.update_attribute(:relisten_url, url)
      end

    end
  end
end