Rails.application.routes.draw do

  root to: 'passengers#index'

  resources :drivers
  resources :passengers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
