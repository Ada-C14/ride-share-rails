Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  # root to: 'homepages#index'
  #
  # resources :rideshare, only: [:index]

  root to: 'drivers#index'

  scope '/rideshare' do
    resources :passengers # only[:show, :index]
    resources :drivers
    resources :trips
  end
end
