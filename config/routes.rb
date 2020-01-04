Rails.application.routes.draw do

  resources :songs
  resources :songs, only: [:index]

end
