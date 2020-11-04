Rails.application.routes.draw do
  # For details on the DSL available within this file, see c
  # root to: 'homepages#index'

  resources :drivers
  resources :passengers
  resources :trips
end
