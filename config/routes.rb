Rails.application.routes.draw do
  get 'merchants/index'
  # We do not need these nested routes because we don't use them. 
  # resources :drivers do
  #   resources :trips, only: [:index, :new]
  # end 

  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :drivers
  resources :passengers
  resources :trips, except: [:new, :create]# we create trip through passenger. 

  root to: 'homepages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
