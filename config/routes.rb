Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/drivers', to: 'drivers#index', as: 'drivers_path'


  get '/drivers/:id', to: 'drivers#show', as: "driver"
end
