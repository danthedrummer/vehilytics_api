Rails.application.routes.draw do
  namespace :v1 do
    get '/sensors', to: 'sensors#index'
  end
end
