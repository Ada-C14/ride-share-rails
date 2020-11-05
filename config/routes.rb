Rails.application.routes.draw do
  resources :drivers
  resources :pasengers
  resources :trips
  
  root to: 'homepages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
