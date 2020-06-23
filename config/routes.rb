Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  get 'users/card'
  get 'users/logout'
  resources :users
  resources :items, only: :show
  resources :buys, only: :index
end
