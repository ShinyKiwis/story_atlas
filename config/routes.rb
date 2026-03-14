Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
  get '/*path', to: 'dashboard#index'

  namespace :api, defaults: { format: :json } do
    post '/first-run', to: 'first_runs#create'
    resources :sessions, only: %i[create destroy]
    resources :users
  end
end
