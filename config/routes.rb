Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :drivers do
    resources :trips, only: [:index]
  end

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :trips, except: [:new, :create]
end
