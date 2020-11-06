Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :drivers do
    resources :trips, only: [:index]
  end

  patch 'drivers/:id/toggle_availability', to: 'drivers#toggle_availability', as: :toggle_availability

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :trips, except: [:new, :create]
end
