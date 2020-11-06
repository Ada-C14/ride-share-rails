Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'
  resources :homepages, only:[:index]

  resources :trips

  resources :drivers, :passengers do
    resources :trips, only:[:index, :create] #driver_trips_path, passenger_trips_path
  end

end
