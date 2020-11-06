Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  get 'homepages/index'

  resources :trips, [:show, :edit, :update, :destroy]
  resources :passengers do
    resources :trips, only: [:create]
  end
  resources :drivers
end


