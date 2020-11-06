Rails.application.routes.draw do

  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status'

  root to: 'homepages#index'
  resources :trips

  resources :drivers do
    resources :trips
  end
  resources :passengers do
    resources :trips
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end

