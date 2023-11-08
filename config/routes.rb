Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :products
  resources :addresses

  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
