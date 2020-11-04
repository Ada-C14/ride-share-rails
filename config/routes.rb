Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :drivers
  resources :passengers
  resources :trips
end
