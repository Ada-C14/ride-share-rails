Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :homepages, only: [:index]

  resources :trips, except: [:new]

  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :drivers

end
