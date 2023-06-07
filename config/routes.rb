Rails.application.routes.draw do
  resources :products
  resources :orders

  get '/cart', to: 'products#show_cart', as: 'cart'
  post '/add_to_cart/:product_id', to: 'products#add_to_cart', as: 'add_to_cart'
  post '/update_amount/:product_id', to: 'products#update_amount', as: 'update_amount'
  post '/remove_from_cart/:product_id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  root "pages#home"
end
