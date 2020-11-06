Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  root to: 'drivers#show'

  resources :rideshare, only: [:index]

  scope '/rideshare' do
    resources :passengers # only[:show, :index]
    resources :drivers
    patch '/rideshare/drivers/:id/availability', to: 'drivers#availability', as: 'availability'

    resources :trips
  end
end
