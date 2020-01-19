Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do

    root to: 'health#index'

    resources :annotations
    resources :tracks
    resources :shows
    resources :bands
    resources :venues
    resources :songs
    resources :users
    post '/auth/login', to: 'authentications#login'
  end

end
