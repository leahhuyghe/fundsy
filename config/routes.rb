Rails.application.routes.draw do
  resources :pledges
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :campaigns

  root "campaigns#index"

end
