Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, :controllers => { registrations: 'v1/user_registrations' }
  devise_for :devices, defaults: { format: :json }, :controllers => { registrations: 'v1/device_registrations' }
  namespace :v1, defaults: { format: :json } do
    resource :sessions, only: [:create, :destroy, :show], controller: "user_sessions"
    resource :device_sessions, only: [:create, :destroy, :show]
    resources :sensors, only: [:index, :create]
    resources :reports, only: [:create]
    resources :readings, only: [:index]
    resources :devices, only: [:create, :index]
    
  end
end
