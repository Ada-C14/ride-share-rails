Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:'homepages#index'

  resources :drivers do
    resources :trips, only: [:show, :new]
  end

  resources :passengers do
    resources :trips, only: [:show, :new]
  end

  resources :trips
end
