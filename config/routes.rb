Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :products
  resources :addresses

  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  post '/signup', to: "users#create"
  get '/me', to: "users#show"

  match "/signup", to: proc { [204, {}, []] }, via: :options
  match "/login", to: proc { [204, {}, []] }, via: :options

end
