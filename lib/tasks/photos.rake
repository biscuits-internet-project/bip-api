namespace :photos do
  task :flickr => [:environment] do
    require 'open-uri'
    require 'active_support/core_ext/hash/conversions'
    require "awesome_print"

    shows = Show.all.to_a
    user = User.first

    sql = "select * from galleries where type = 'flickr';"
    records = ActiveRecord::Base.connection.execute(sql)

    records.each do |record|
      show = shows.find { |s| s.legacy_id == record["showid"] }

      doc = Nokogiri::XML(open(record["url"]))
      hash = Hash.from_xml(doc.to_s)

      hash["feed"]["entry"].each do |entry|
        label = entry["author"]["uri"]

        entry["link"].each do |item|
          if item["type"] == "image/jpeg"
            url = item["href"]

            filename = File.basename(URI.parse(url).path)
            file = open(url)

            photo = ShowPhoto.create(show: show, user: user, label: label, source: url)
            photo.image.attach(io: file, filename: filename)
          end
        end
      end
    end

  end
end