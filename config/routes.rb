Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: 'homepages#index'

  resources :homepages, only: [:index]

  get '/trips', to: 'trips#index', as: 'trips'
  get '/trips/new', to: 'trips#new', as: 'new_trip'
  post '/trips', to: 'trips#create'

  get '/trips/:id', to: 'trips#show', as: 'trip'
  get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
  patch '/trips/:id', to: 'trips#update'
  delete '/trips/:id', to: 'trips#destroy'


  # driver routes
  resources :drivers do
    resources :trips, only: [:index, :new, :create]
  end

  # get '/drivers', to: 'drivers#index', as: 'drivers'
  # get '/drivers/new', to: 'drivers#new', as: 'new_driver'
  # post '/drivers', to: 'drivers#create'
  #
  #
  # get '/drivers/:id', to: 'drivers#show', as: 'driver'
  # get '/drivers/:id/edit', to: 'drivers#edit', as: 'edit_driver'
  # patch '/drivers/:id', to: 'drivers#update'
  # get 'drivers/:id/confirm_delete', to: 'drivers#confirm', as: 'confirm_driver'
  # delete '/drivers/:id', to: 'drivers#delete'

  # Passengers routes
  resources :passengers do
    resources :trips, only: [:index, :new, :create]
  end

  resources :trips
  # get '/passengers', to: 'passengers#index', as: 'passengers'
  # get '/passengers/new', to: 'passengers#new', as: 'new_passenger'
  # post '/passengers', to: 'passengers#create'
  #
  # get '/passengers/:id', to: 'passengers#show', as: 'passenger'
  # get '/passengers/:id/edit', to: 'passengers#edit', as: 'edit_passenger'
  # patch '/passengers/:id', to: 'passengers#update'
  # delete '/passengers/:id', to: 'passengers#destroy'


end
