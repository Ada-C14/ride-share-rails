Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # what should our root_path be?

  resources :trips
  resources :drivers
  resources :passengers

end
