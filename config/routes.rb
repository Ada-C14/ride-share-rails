Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :passengers do
    resources :trips, only: [:new]
  end

  resources :drivers
  resources :trips

end
