Rails.application.routes.draw do

  root 'playlists#find'

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

  get '/playlists' => 'playlists#index', as: 'playlists'
  get '/playlists/new' => 'playlists#new'
  get '/playlists/:id' => 'playlists#show'
  get "/playlists/find" => "playlists#find"
  post "/playlists/verify" => "playlists#verify"

  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create'

  get "/sessions/new" => "sessions#new", as: "new_session"
  post "/sessions" => "sessions#create"

  get '/auth/spotify/callback' => 'users#spotify'
end
