Rails.application.routes.draw do
  resources :users, only: [:show]
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  
end
