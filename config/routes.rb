Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index' 
  resources :users, only: [:index, :show] do
    collection do
      get 'logout'
    end
  end
  resources :items do
    collection do
      get 'children', defaults: { format: 'json' }
      get 'grandchildren', defaults: { format: 'json' }
    end
    resources :favorites , only: [:create, :destroy]
  end
  resources :favorites , only:[:index]
  resources :purchase, only: [:show] do
    member do
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  resources :credit_cards, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end
  resources :categories
  resources :searches,only:[:index]
end
