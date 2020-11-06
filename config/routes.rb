Rails.application.routes.draw do
  root to: 'homepages#index'

  get 'homepages/index', to: 'homepages#index', as: 'homepages'

  get '/trips', to: 'trips#index', as: 'trips'
  get '/trips/:id', to: 'trips#show', as: 'trip'
  get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
  patch '/trips/:id', to: 'trips#update'
  delete '/trips/:id', to: 'trips#destroy'

  resources :passengers

  resources :drivers

  resources :passenger do
    resources :trips, only: [:create]
  end
end
