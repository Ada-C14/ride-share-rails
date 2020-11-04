Rails.application.routes.draw do
  get 'homepages/index'
  get 'homepages/show'

  get '/trips', to: 'trips#index', as: 'trips'
  get '/trips/:id', to: 'trips#show', as: 'trip'

  get '/passengers', to: 'passengers#index', as: 'passengers'
  get '/passengers/:id', to: 'passengers#show', as: 'passenger'

  get '/drivers', to: 'drivers#index', as: 'drivers'
  get '/drivers/:id', to: 'drivers#show', as: 'driver'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
