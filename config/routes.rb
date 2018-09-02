Rails.application.routes.draw do
  resources :healths, only: [:index]
  resources :stats, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
