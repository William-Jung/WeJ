Rails.application.routes.draw do

  root 'playlists#find'

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

  get '/playlists' => 'playlists#index', as: 'playlists'
  get '/playlists/new' => 'playlists#new', as: 'new_playlist'
  get "/playlists/find" => "playlists#find"
  get '/playlists/:id' => 'playlists#show'
  get '/playlists/:id/admin' => 'playlists#admin', as: 'playlist_admin'
  post "/playlists/verify" => "playlists#verify"
  put '/playlists' => 'playlists#update'

  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create'

  get "/sessions/new" => "sessions#new", as: "new_session"
  post "/sessions" => "sessions#create"

  get '/auth/spotify/callback' => 'users#spotify'

end
