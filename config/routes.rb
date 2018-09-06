Rails.application.routes.draw do
  #  resources :healths, only: [:index]
  get '/healthcheck', to: 'healths#index'
  resources :stats, only: [:index]
  get '/shutdown', to: 'stats#shutdown'
  get '/restart', to: 'stats#restart'
  get '/corrupt', to: 'stats#corrupt'
  get '/uncorrupt', to: 'stats#uncorrupt'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
