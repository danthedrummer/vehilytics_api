Rails.application.routes.draw do
  namespace :v1 do
    get '/sensors', to: 'sensors#index'
    get '/sensors/:id', to: 'sensors#show'
    
    post '/reports', to: 'reports#create'
  end
end
