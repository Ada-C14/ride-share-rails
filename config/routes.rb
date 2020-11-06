Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :drivers do
    resources :trips
  end
  resources :passengers do
    resources :trips
    end
  resources :trips
end
