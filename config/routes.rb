Rails.application.routes.draw do
  root 'top#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show]
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get "search" => "searches#search"

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :habits do
    resource :records, only: [:create]
    member do
      patch 'achieve'
    end
    get "challenge" => "challenges#index"
    resource :challenges, only: %w(create destroy)
  end

 
end
