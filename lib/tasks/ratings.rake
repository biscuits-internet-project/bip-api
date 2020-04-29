namespace :ratings do
  task :polymorphic => [:environment] do
    ratings = Rating.all.to_a
    ratings.each do |rating|
      rating.rateable_type = 'Show'
      rating.rateable_id = rating.show_id
    end
  end
end