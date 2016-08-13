Rails.application.routes.draw do
<<<<<<< HEAD

  root 'spotify#show'

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

=======
  root 'playlists#index'
  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create' 
  get "/sessions/new" => "sessions#new"
  post "/sessions" => "sessions#create"
>>>>>>> master
end
