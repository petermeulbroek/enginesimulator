Rails.application.routes.draw do
  resources :healths, only: [:index]
  resources :stats, only: [:index]

  get '/shutdown', to: 'stats#shutdown'
  get '/destroy', to: 'stats#destroy'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
