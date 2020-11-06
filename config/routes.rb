Rails.application.routes.draw do

  resources :drivers do
    resources :trips, only: [:index, :new]
  end

  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :drivers
  resources :passengers
  resources :trips

  root to: 'homepages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
