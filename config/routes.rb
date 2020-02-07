Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do

    root to: 'health#index'

    resources :tracks
    resources :shows do
      post :attend, on: :member
      post :unattend, on: :member
    end
    resources :bands
    resources :venues
    resources :songs
    resources :users
    resources :authors

    scope path: '/:resource_type/:resource_id', shallow_path: "" do
      post :like, to: 'likes#create'
      post :unlike, to: 'likes#destroy'

      resources :reviews, shallow: true
    end

    get '/tracks/songs/:song_id', to: 'tracks#index'
    post '/auth/login', to: 'authentications#login'
    post '/auth/register', to: 'authentications#register'
    get '/auth/confirm', to: 'authentications#confirm'
    post '/auth/password/reset', to: 'authentications#password_reset'
    put '/auth/password/update/:token', to: 'authentications#password_update'
    post '/contact', to: 'contact#create'
  end

end
