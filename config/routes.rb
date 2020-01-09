Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }

  #resources :users
  resources :health, only: [:show]
  resources :annotations
  resources :tracks
  resources :shows
  resources :bands
  resources :venues
  resources :songs, only: [:index]

end
