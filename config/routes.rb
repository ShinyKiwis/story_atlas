Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
  get '/login', to: 'sessions#new'
  get '/first-run', to: 'first_runs#new'
  get '/*path', to: 'dashboard#index'

  scope :api, defaults: { format: :json } do
    post '/first-run', to: 'first_runs#create'
    resources :sessions, only: %i[create destroy]
    resources :users
  end
end
