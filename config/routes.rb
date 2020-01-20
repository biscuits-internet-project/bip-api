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
    post '/auth/register', to: 'authentications#register'
    post '/auth/confirm', to: 'authentications#confirm'
    post '/auth/password/reset', to: 'authenticatiosn#password_reset'
    put '/auth/password/update', to: 'authentications#password_update'
  end

end
