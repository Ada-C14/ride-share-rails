Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'


  resources :drivers
  # don't we need trips :index and :new for the nested routes?
  # :create
  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :trips, except: [:index, :new]
end
