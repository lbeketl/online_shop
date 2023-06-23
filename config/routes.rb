Rails.application.routes.draw do
  resources :products, only: [:show, :index]
  resources :orders, exept: :edit

  resources :carts do
    get :show, on: :collection
    post :create, on: :member
    put :update, on: :member
    delete :destroy, on: :member

  end

  root "pages#home"
end
