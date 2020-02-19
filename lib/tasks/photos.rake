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

      begin
        doc = Nokogiri::XML(open(record["url"]))
        hash = Hash.from_xml(doc.to_s)
      rescue
        failed << record["id"]
        next
      end

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
      rescue
        failed << record["id"]
        next
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

      begin
        doc = Nokogiri::XML(open(record["url"]))
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
      rescue
        failed << record["id"]
        next
      end
    end

    puts '===== failed ======'
    puts failed.inspect
  end

  task :files => [:environment] do

    shows = Show.all.to_a
    user = User.first

    base_dir = pwd + "/lib/photos"
    skip = [".", "..", ".DS_Store"]

    Dir.open(pwd + "/lib/photos").each do |year|
      next if skip.include?(year)
      puts year
      Dir.open("#{base_dir}/#{year}").each do |month|
        next if skip.include?(month)
        puts month
        Dir.open("#{base_dir}/#{year}/#{month}").each do |day|
          next if skip.include?(day)
          puts day
          date = Date.new(year.to_i, month.to_i, day.to_i)
          show = shows.find { |s| s.date == date }
          puts show

          Dir.open("#{base_dir}/#{year}/#{month}/#{day}").each_with_index do |f, i|
            next if skip.include?(f)

            extname = File.extname("#{base_dir}/#{year}/#{month}/#{day}/#{f}")
            filename = "#{year}-#{month}-#{day}-#{i}#{extname}"
            f = File.open("#{base_dir}/#{year}/#{month}/#{day}/#{f}")

            photo = ShowPhoto.create(show: show, user: user, label: "dbnet", source: "dbnet")
            photo.image.attach(io: f, filename: filename)
          end
        end
      end
    end

  end
end