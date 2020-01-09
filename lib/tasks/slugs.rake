namespace :slugs do
  task :venues => [:environment] do
    Venue.find_each(&:save)
  end

  task :bands => [:environment] do
    Band.find_each(&:save)
  end

  task :songs => [:environment] do
    Song.find_each(&:save)
  end

  task :shows => [:environment] do
    Show.find_each(&:save)
  end
end