Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  resources :drivers do
    # resources :trips
  end
  resources :passengers do
    resources :trips, only: [:create]
  end
  resources :trips

end

