Rails.application.routes.draw do

  resources :discussions do
    resources :comments, only: [:create, :destroy]

  end
  resources :pledges
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :campaigns do
    resources :comments, only: [:create, :destroy]
    resources :publishings, only: [:create]
  end

  root "campaigns#index"

end
