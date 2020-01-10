namespace :authors do
  task :build => [:environment] do
    songs = Song.where.not(legacy_author: ['', nil]).to_a
    songs.each do |song|
      author = Author.find_by_name(song.legacy_author.strip) || Author.create(name: song.legacy_author.strip)
      song.author = author
      song.save!
    end
  end
end