Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :products
  resources :addresses

  post 'add_to_cart/:product_id', to: 'orders#add_to_cart', on: :member, as: :add_to_cart
  patch 'reduce_quantity/:order_item_id', to: 'orders#reduce_quantity', on: :member, as: :reduce_quantity
  delete 'remove_from_cart/:order_item_id', to: 'orders#remove_from_cart', on: :member, as: :remove_from_cart


  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  post '/signup', to: "users#create"
  get '/me', to: "users#show"

  match "/signup", to: proc { [204, {}, []] }, via: :options
  match "/login", to: proc { [204, {}, []] }, via: :options

end
