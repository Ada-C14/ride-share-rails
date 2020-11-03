Rails.application.routes.draw do
  resources :drivers
  resources :passengers
  resources :trips

  # get 'trips/index'
  # get 'passengers/index'
  # get 'drivers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
