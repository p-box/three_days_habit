Rails.application.routes.draw do
  get 'habits/index'
  get 'relationships/followings'
  get 'relationships/followers'
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

  resources :posts

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

  resources :user do
    resource :habits, only: [:index]
  end
 
end
