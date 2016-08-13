Rails.application.routes.draw do

  root 'playlists#find'

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

  get '/users/new' => 'users#new', as: "new_user"

  post '/users' => 'users#create'

  get "/sessions/new" => "sessions#new"

  post "/sessions" => "sessions#create"

  get "/playlists/find" => "playlists#find"

  post "/playlists/verify" => "playlists#verify"

end
