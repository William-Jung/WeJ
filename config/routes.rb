Rails.application.routes.draw do
  root 'playlists#index'
  get '/users/new' => 'users#new', as: "new_user"
  post '/users' => 'users#create' 
end
