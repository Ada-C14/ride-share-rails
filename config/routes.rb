Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'

  get '/passengers', to: 'passengers#index', as: 'passengers'
  get '/passengers/:id', to: 'passengers#show', as: 'passenger'
end
