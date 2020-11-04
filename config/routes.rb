Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'drivers#index'
  resources :drivers do
    resources :trips, only: [:index]
  end

  resources :passengers do
    resources :trips, only: [:index, :new]
  end

  resources :trips, except: [:index] do
    resources :drivers, only: [:index]
    resources :passengers, only: [:index]
  end


end
