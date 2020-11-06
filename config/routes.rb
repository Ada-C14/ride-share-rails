Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'homepages#index'

  get '/homepages', to: 'homepages#index', as: 'homepages'
  get '/drivers', to: 'drivers#index', as: 'drivers_path'
  get '/drivers/new', to: 'drivers#new', as: 'new_driver'
  post '/drivers', to: 'drivers#create'
  get '/drivers/:id/edit', to: 'drivers#edit', as: 'edit_driver'
  patch '/drivers/:id', to: 'drivers#update'
  get '/drivers/:id', to: 'drivers#show', as: "driver"
  delete '/drivers/:id', to: 'drivers#destroy', as: 'destroy_driver'
  patch 'drivers/:id/available', to: 'drivers#set_available', as: 'available_driver'



  get '/passengers', to: 'passengers#index', as: 'passengers_path'
  get '/passengers/new', to: 'passengers#new', as: 'new_passenger'
  get '/passengers/edit', to: 'passengers#edit', as: 'edit_passenger'
  get '/passengers/:id', to: 'passengers#show', as: "passenger"

  post '/passengers', to: 'passengers#create'
  delete '/passengers/:id', to: 'passengers#destroy', as: 'destroy_passenger'

end
