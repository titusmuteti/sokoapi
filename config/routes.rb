Rails.application.routes.draw do
  resources :order_items
  resources :users
  resources :products
  resources :addresses
  resources :orders

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'

  match '/signup', to: proc { [204, {}, []] }, via: :options
  match '/login', to: proc { [204, {}, []] }, via: :options
end
