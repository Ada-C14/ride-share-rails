Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :homepages, only: [:index]

  resources :trips

  resources :passengers

  resources :drivers

  resources :passenger do
    resources :trips, only: [:create]
  end
end
