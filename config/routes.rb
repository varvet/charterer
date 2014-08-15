Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :images, only: [:index, :update]
  resources :users, only: [:show]
  root 'images#index'
end
