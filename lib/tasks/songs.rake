namespace :songs do
  task :stats => [:environment] do

    Song.includes(:shows).each(&:update_stats)

  end
end