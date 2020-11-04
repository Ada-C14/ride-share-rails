Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'
  resources :drivers, :passengers
  resources :trips, except[:new, :index]
  resources :homepages, only:[:index]
end
