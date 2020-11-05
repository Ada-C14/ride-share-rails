Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :drivers, :trips

  resources :trips, except: [:create]

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  delete '/drivers/:id', to: 'drivers#delete', as: 'delete_driver'

  #root to: do the root
end
