Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/drivers/', to: 'drivers#index', as: :driver
  get '/passengers/', to: 'passengers#index', as: :passenger
  get '/trips/', to: 'trips#index', as: :trip
end
