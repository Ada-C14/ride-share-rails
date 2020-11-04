Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'

  get '/drivers/', to: 'drivers#index', as: :drivers
  get '/passengers/', to: 'passengers#index', as: :passengers
  get '/trips/', to: 'trips#index', as: :trips


  get '/drivers/:id', to: 'drivers#show', as: :driver
  get '/passengers/:id', to: 'passengers#show', as: :passenger
  get '/trips/:id', to: 'trips#show', as: :trip
end
