Rails.application.routes.draw do

  root to: 'health#index'

  resources :annotations
  resources :tracks
  resources :shows
  resources :bands
  resources :venues
  resources :songs, only: [:index]

end
