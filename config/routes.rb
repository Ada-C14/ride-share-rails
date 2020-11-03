Rails.application.routes.draw do

  #root to home page controller index
  root to: 'drivers#index'

  resources :drivers
  resources :passengers
  resources :trips
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
