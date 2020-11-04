Rails.application.routes.draw do
  get 'drivers/index', to: 'drivers#index', as: 'drivers'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
