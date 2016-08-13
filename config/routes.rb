Rails.application.routes.draw do

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

  root 'playlists#index'
  get 'playlists/new' => 'playlists#new'
  get '/playlists/:id' => 'playlists#show'
  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  get "/sessions/new" => "sessions#new"
  post "/sessions" => "sessions#create"
  get '/auth/spotify/callback' => 'users#spotify'
end
