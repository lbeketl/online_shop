Rails.application.routes.draw do
  resources :products
  resources :orders

  resources :carts do
    post :create, on: :member
    put :update, on: :member
    delete :destroy, on: :member
    get :show, on: :collection
  end

  root "pages#home"
end
