Rails.application.routes.draw do

  resources :drivers
  resources :passengers

  # verb 'path', to: 'controller#action'
  #  get '/drivers', to: 'drivers#index', as: 'drivers'
  #  root to: 'drivers#index'
  #  get '/drivers/new', to: 'drivers#new', as: 'new-driver'
  #  post '/drivers', to: 'drivers#create'

  #  #routes that operates on individual driver
  #  get '/drivers/:id', to: 'drivers#show', as: 'driver'
  #  get '/drivers/:id/edit', to: 'drivers#edit', as: 'edit_driver'
  #  patch '/drivers/:id', to: 'drivers#update'
  #  delete '/drivers/:id', to: 'drivers#destroy'
end
