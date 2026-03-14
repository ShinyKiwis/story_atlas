Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
  get '/first-run', to: 'first_runs#show'
  get '/login', to: 'sessions#new'

  scope :api, defaults: { format: :json } do
    post '/first-run', to: 'first_runs#create'
    resources :sessions, only: %i[create destroy]
    resources :users
  end
end
