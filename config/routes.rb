Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do

    root to: 'health#index'

    resources :tracks
    resources :shows, shallow_path: "" do
      post :attend, on: :member
      post :unattend, on: :member
      get :photos, on: :member, to: "show_photos#index"
    end
    resources :bands
    resources :venues
    resources :songs do
    end
    resources :users
    resources :authors
    resources :side_projects, only: [:index]

    scope path: '/:resource_type/:resource_id', shallow_path: "" do
      post :like, to: 'likes#create'
      post :unlike, to: 'likes#destroy'

      resources :reviews, shallow: true
    end

    post '/songs/slugs', to: 'songs#index'
    get '/tracks/songs/:song_id', to: 'tracks#index'
    post '/auth/login', to: 'authentications#login'
    post '/auth/register', to: 'authentications#register'
    get '/auth/confirm', to: 'authentications#confirm'
    post '/auth/password/reset', to: 'authentications#password_reset'
    put '/auth/password/update/:token', to: 'authentications#password_update'
    post '/contact', to: 'contact#create'
    get '/clear', to: 'health#clear_cache'
  end

end
