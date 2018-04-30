Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json } do
    resource :sessions, only: [:create, :destroy, :show] 
    resources :sensors, only: [:index, :show]
    resources :reports, only: [:create, :index]
    resources :readings, only: [:index]
  end
end
