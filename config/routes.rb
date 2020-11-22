Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  root to: 'drivers#show'

  resources :rideshare, only: [:index]

  resources :drivers
  patch 'drivers/:driver_id/availability', to: 'drivers#availability', as: 'availability'
  resources :trips

  resources :passengers do
    resources :trips, only: [:create]
  end

end
