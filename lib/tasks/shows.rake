namespace :shows do
  task :relisten => [:environment] do

    shows = Show.where.not(date: nil).to_a

    shows.each do |show|

      url = "https://relistenapi.alecgorge.com/api/v2/artists/disco-biscuits/years/#{show.date.stamp("1999")}/#{show.date.stamp("1999-12-31")}"
      response = HTTParty.get(url)

      if response.code == 200 && response[:error_code] != 404
        link = "https://relisten.net/disco-biscuits/#{show.date.stamp('2009/01/16')}"
        show.update_attribute(:relisten_url, link)
      end

    end
  end
end