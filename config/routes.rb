Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'
  resources :homepages, only:[:index]

  resources :trips
  resources :passengers

  resources :drivers do
    resources :trips, only:[:index, :new]
  end

end
