Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'

  get '/drivers/', to: 'drivers#index', as: :drivers
  get '/passengers/', to: 'passengers#index', as: :passengers
  get '/trips/', to: 'trips#index', as: :trips

  get '/trips/new', to: "trips#new", as: :new_trip
  get '/passengers/new', to: 'passengers#new', as: :new_passenger
  get '/drivers/new', to: 'drivers#new', as: :new_driver

  get '/drivers/:id', to: 'drivers#show', as: :driver
  get '/passengers/:id', to: 'passengers#show', as: :passenger
  get '/trips/:id', to: 'trips#show', as: :trip

  post '/drivers', to: "drivers#create"
  post '/passengers', to: "passengers#create"
  post '/trips', to: "trips#create"

end
