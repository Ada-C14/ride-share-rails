Rails.application.routes.draw do
  resources :drivers
  resources :passengers
  resources :trips

  get '/drivers/:driver_id/trips', to: 'trips#index', as: 'driver_trips'
  get '/passengers/:passenger_id/trips', to: 'trips#index', as: 'passenger_trips'
  get '/drivers/:driver_id/trips/:trip_id', to: 'trips#show'
  get '/passengers/:passenger_id/trips/:trip_id', to: 'trips#show'
  root to: 'homepages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
