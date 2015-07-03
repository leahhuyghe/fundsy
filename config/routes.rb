Rails.application.routes.draw do
  resources :pledges
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resources :campaigns

  root "users#new"

end
