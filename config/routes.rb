Rails.application.routes.draw do
  # resources :users, only: [:show]
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  
end
