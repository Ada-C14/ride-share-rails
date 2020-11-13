Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'homepages#index'

  resources :drivers do
    resources :trips, only: [:index]
  end
  resources :passengers do
    resources :trips, only: [:index]
  end

  post '/passenger/:passenger_id/trip', to: 'trips#create', as: 'passenger_create_trip'

  resources :trips

  patch "/drivers/:id/toggle", to: "drivers#toggle_available", as: "toggle_available"
end
