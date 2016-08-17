Rails.application.routes.draw do

  root 'playlists#find'

  get '/spotify' => 'spotify#show'
  post '/spotify' => 'spotify#search'
  get '/spotify/show' => 'spotify#show'

  get '/playlists' => 'playlists#index', as: 'playlists'
  get '/playlists/new' => 'playlists#new', as: 'new_playlist'
  post '/playlists' => 'playlists#create'
  get "/playlists/find" => "playlists#find"
  get '/playlists/send_mobile' => 'playlists#send_mobile'
  get '/playlists/:id' => 'playlists#show', as: 'show_playlist'
  get '/playlists/:id/admin' => 'playlists#admin', as: 'playlist_admin'
  get '/playlists/:id/edit' => 'playlists#edit', as: 'playlist_edit'
  post "/playlists/verify" => "playlists#verify"
  put '/playlists' => 'playlists#update'


  delete '/playlistsongs/:id' => 'playlistsongs#destroy', as: 'playlistsong'
  get '/playlist/:playlist_id/playlistsongs' => 'playlistsongs#songs', as: 'send_songs'
  put '/playlist/:playlist_id/playlistsongs' => 'playlistsongs#update'
  # get '/playlists/:playlistsong_id/has_been_played' => 'playlistsongs#test_update'

  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create'

  get "/sessions/new" => "sessions#new", as: "new_session"
  post "/sessions" => "sessions#create"
  get '/sessions/delete' => 'sessions#destroy', as: 'logout'
  post "/sessions/mobile" => 'sessions#mobileAuth'

  get '/auth/spotify/callback' => 'users#spotify'

  post '/votes' => 'votes#create'

end
