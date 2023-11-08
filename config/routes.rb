Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :products
  resources :addresses

  post '/login', to: "session#create"
  delete '/logout', to: "session#destroy"

  get '/check_user', to: "session#check_user"

end
