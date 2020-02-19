namespace :photos do

  require 'open-uri'
  require 'active_support/core_ext/hash/conversions'
  require "awesome_print"

  task :flickr => [:environment] do
    shows = Show.all.to_a
    user = User.first

    sql = "select * from galleries where type = 'flickr';"
    records = ActiveRecord::Base.connection.execute(sql)
    failed = []

    records.each do |record|
      show = shows.find { |s| s.legacy_id == record["showid"] }

      doc = begin
        Nokogiri::XML(open(record["url"]))
      rescue
        next
      end

      begin
        hash = Hash.from_xml(doc.to_s)
      rescue
        failed << record["id"]
        next
      end

      hash["feed"]["entry"].each do |entry|

        begin
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
        rescue
          failed << record["id"]
          next
        end
      end

    end
    puts '===== failed ======'
    puts failed.uniq.inspect
  end

  task :photobucket => [:environment] do
    shows = Show.all.to_a
    user = User.first

    sql = "select * from galleries where type = 'photobucket' limit 1;"
    records = ActiveRecord::Base.connection.execute(sql)
    failed = []

    records.each do |record|
      show = shows.find { |s| s.legacy_id == record["showid"] }

      doc = begin
        Nokogiri::XML(open(record["url"]))
      rescue OpenURI::HTTPError
        failed << record["id"]
        next
      end

      begin REXML::UndefinedNamespaceException
        hash = Hash.from_xml(doc.to_s)
      rescue
        failed << record["id"]
        next
      end

      source = hash["rss"]["channel"]["link"]

      hash["rss"]["channel"]["item"].each do |item|
        url = item["enclosure"]["url"]
        label = item["creator"]
        filename = File.basename(URI.parse(url).path)
        file = open(url)
        photo = ShowPhoto.create(show: show, user: user, label: label, source: source)
        photo.image.attach(io: file, filename: filename)
      end
    end

    puts '===== failed ======'
    puts failed.inspect
  end
end