Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index' 
  resources :cards, only: :index
  resources :users, only: [:index, :show] do
    collection do
      get 'logout'
    end
  end
  resources :items, only: [:index, :show, :new]
  resources :buys, only: :index
end
