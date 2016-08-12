Rails.application.routes.draw do

  root 'spotify#show'

  get '/spotify' => 'spotify#show'

  post '/spotify' => 'spotify#search'

  get '/spotify/show' => 'spotify#show'

end
