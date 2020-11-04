Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  root to: 'rideshare#index'

  resources :rideshare, only: [:index]


  scope '/rideshare' do
    resources :passengers # only[:show, :index]
    resources :drivers
    resources :trips
  end
end
