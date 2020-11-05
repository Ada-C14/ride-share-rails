Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :drivers, :passengers, :trips

  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  #root to: do the root
end
