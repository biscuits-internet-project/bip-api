namespace :tracks do

  task :inverted_tags => [:environment] do
    tracks = Track.joins(:annotations).where("annotations.desc like ('%Inverted%') or annotations.desc like ('%inverted%')").to_a
    tracks.each do |t|
      t.tag_list.add("inverted")
      t.save
    end
  end

  task :unfinished_tags => [:environment] do
    tracks = Track.joins(:annotations).where("annotations.desc ILIKE ('%unfinished%')").to_a
    tracks.each do |t|
      t.tag_list.add("unfinished")
      t.save
    end
  end

  task :ending_only_tags => [:environment] do
    tracks = Track.joins(:annotations).where("annotations.desc ILIKE ('end only%') OR annotations.desc ILIKE ('ending only')").to_a
    tracks.each do |t|
      t.tag_list.add("ending-only")
      t.save
    end
  end

  task :dub_tags => [:environment] do
    tracks = Track.joins(:annotations).where("annotations.desc ILIKE ('%dub%') OR annotations.desc ILIKE ('%reggae%')").to_a
    tracks.each do |t|
      t.tag_list.add("dub")
      t.save
    end
  end

  task :dyslexic_tags => [:environment] do
    tracks = Track.joins(:annotations).where("annotations.desc ILIKE ('%dyslexic%')").to_a
    tracks.each do |t|
      t.tag_list.add("dyslexic")
      t.save
    end
  end

  task :backfill => [:environment] do
    Track.where(previous_track_id: nil, next_track_id: nil).each(&:update_previous_and_next_tracks)
  end

  task :build => [:environment] do
    shows = Show.all.to_a
    songs = Song.all.to_a
    legacy_shows = LegacyShow.where(band: 1).order(:id).to_a

    legacy_shows.each do |ls|

      show = shows.find { |s| s.legacy_id == ls.id }
      if show.nil?
        raise "can't find show for legacy id #{ls.id}"
      end

      #puts show.inspect
      #puts ls.inspect

      # sets
      [1, 2, 3, 4].each do |num|
        build_set("S#{num}", ls.send("set#{num}".to_sym), ls, show, songs)
      end

      # encores
      [1, 2].each do |num|
        build_set("E#{num}", ls.send("encore#{num}".to_sym), ls, show, songs)
      end
    end

  end

  def build_set(set_number, setlist, legacy_show, show, songs)
    return if setlist.blank?
    set_parts = setlist.split(" ")
    tracks = []

    set_parts.each_with_index do |set_part, i|
      next if set_part == ","

      # set part is a segue
      if set_part == ">" || set_part == '->'
        tracks.last.segue = ">" unless tracks.last.nil?
      # set part is an annotation
      elsif set_part.to_i.to_s == set_part
        if set_part.to_i > 10
          puts legacy_show.inspect
          puts "annotation is bad: #{set_part}"
          next
        end
        desc = legacy_show.send("comment#{set_part.to_i}".to_sym)
        next if desc.blank?
        tracks.last.annotations << Annotation.new(desc: desc.gsub("<br>", ""))
      # set part is a regular ole song
      else
        track = Track.new

        song = songs.find { |s| s.legacy_abbr == set_part }
        if song.nil?
          puts legacy_show.inspect
          puts "can't find song for legacy abbr #{set_part}"
          next
        end

        track.song = song
        track.set = set_number
        track.show = show

        tracks << track
      end
    end

    tracks.each_with_index do |track, i|
      begin
        track.position = i + 1
        track.save!
      rescue StandardError => e
        puts e
      end
    end
  end
end