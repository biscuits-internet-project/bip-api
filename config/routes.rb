Rails.application.routes.draw do

  resources :comments
  scope :api, defaults: { format: :json } do

    root to: 'health#index'

    resources :blog_posts do
      put :publish, on: :member
      get :tags, on: :collection
      resources :comments, shallow: true
    end
    resources :tracks, except: [:create] do
      get :charts, on: :collection
    end
    resources :shows, shallow_path: "" do
      resources :tracks, only: [:create]
      post :attend, on: :member
      post :unattend, on: :member
      post :favorite, on: :member
      post :unfavorite, on: :member
      get :photos, on: :member, to: "show_photos#index"
      get :user, on: :collection
      resources :reviews, only: [:create, :index]
    end
    resources :bands
    resources :venues
    resources :songs
    resources :users
    resources :authors
    resources :side_projects, only: [:index]
    resources :media_contents
    resources :reviews, except: [:create]

    scope path: '/:resource_type/:resource_id', shallow_path: "" do
      post :like, to: 'likes#create'
      post :unlike, to: 'likes#destroy'

      post :rate, to: 'ratings#create'
    end

    get '/metrics', to: 'metrics#index'
    get '/attendances', to: 'users#attendances'
    get '/ratings', to: 'users#ratings'
    get '/favorites', to: 'users#favorites'
    post '/songs/slugs', to: 'songs#index'
    get '/tracks/songs/:song_id', to: 'tracks#index'
    post '/auth/login', to: 'authentications#login'
    post '/auth/register', to: 'authentications#register'
    get '/auth/confirm', to: 'authentications#confirm'
    get '/auth/refresh', to: 'authentications#refresh'
    post '/auth/password/reset', to: 'authentications#password_reset'
    put '/auth/password/update/:token', to: 'authentications#password_update'
    post '/contact', to: 'contact#create'
    get '/clear', to: 'health#clear'
  end

end
