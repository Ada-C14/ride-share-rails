Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :drivers
  resources :passengers
  resources :homepages, only: [:index]
  resources :trips, except: [:create] do
    member do
      patch :assign_rating
    end
  end
  resources :passengers do
    resources :trips, only: [:index, :create]
  end
  delete '/drivers/:id', to: 'drivers#delete', as: 'delete_driver'

  root to: 'homepages#index'
end