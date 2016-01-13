Rails.application.routes.draw do
  resources :cart_staches, only: [:create, :destroy]
  resource :cart, only: [:show]
  resources :staches, only: [:index, :show]
  resources :categories, only: [:index, :show]
  post 'update_quantity', to: 'cart_staches#update_quantity'
  root 'categories#index'
end
