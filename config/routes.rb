Rails.application.routes.draw do

  root to: "sessions#new"

  get "/sessions/new" => "sessions#new"
  post "/sessions" => "sessions#create"

end
