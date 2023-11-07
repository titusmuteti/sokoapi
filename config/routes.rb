Rails.application.routes.draw do
  resources :orders
  resources :users
  resources :products
  resources :addresses

end
