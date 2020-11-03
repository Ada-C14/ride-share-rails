Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: 'homepage'

  get '/drivers', to: 'drivers#index', as: 'drivers_path'
  get '/drivers/new', to: 'drivers#new', as: 'new_driver'
  post '/drivers', to: 'drivers#create'

  get '/drivers/:id', to: 'drivers#show', as: "driver"
end
