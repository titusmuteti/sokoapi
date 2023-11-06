Rails.application.routes.draw do
root 'products#index'

  resources :orders
  resources :users
  resources :products

end
