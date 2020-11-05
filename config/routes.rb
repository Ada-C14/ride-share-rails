Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index', as: 'homepage'

    resources :trips, only: [:show, :edit, :update, :destroy]

    resources :passengers do
      resources :trips, only: [:create]
    end

    resources :drivers do
      resources :trips, only: [:index, :new]
    end
  end


  
#   #Passenger Routes
#   get '/passengers', to: 'passengers#index', as: 'passengers'
#   get '/passengers/:id', to: 'passengers#show', as: 'passenger'
#   get '/passengers/new', to: 'passengers#new', as: 'new_passenger'
#   post '/passengers', to: 'passengers#create'
#   delete '/passengers/:id', to: 'passengers#destroy' #as delete_passenger?
#   get '/passengers/:id/edit', to: 'passengers#edit', as: 'edit_passenger'
#   patch '/passengers/:id', to: 'passengers#update'
#
#   #Driver Routes
#   get '/drivers', to: 'drivers#index', as: 'drivers'
#   get '/drivers/:id', to: 'drivers#show', as: 'driver'
#   get '/drivers/new', to: 'drivers#new', as: 'new_driver'
#   post '/drivers', to: 'drivers#create'
#   delete '/drivers/:id', to: 'drivers#destroy' #as delete_driver?
#   get '/drivers/:id/edit', to: 'drivers#edit', as: 'edit_driver'
#   patch '/drivers/:id', to: 'drivers#update'
#
#   #Trip routes
#   #do we need trip index?
#   get '/trips/:id', to: 'trips#show', as: 'trip'
#   get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
#   patch '/trips/id', to: 'trips#update'
#   delete '/trips/id', to: 'trips#destroy'
# end
