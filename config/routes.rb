Rails.application.routes.draw do

  resources :annotations
  resources :tracks
  resources :shows
  resources :bands
  resources :venues
  resources :songs
  resources :songs, only: [:index]

end
