Rails.application.routes.draw do
  root to: 'homepage#index'
  resources :passengers
  resources :drivers
  resources :trips
end
