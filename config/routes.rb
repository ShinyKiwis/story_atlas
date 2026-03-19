Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
  get '/login', to: 'sessions#new'
  get '/first-run', to: 'first_runs#new'

  scope :api, defaults: { format: :json } do
    post '/first-run', to: 'first_runs#create'
    get '/users/me', to: 'users#me'

    resources :sessions, only: %i[create]
    delete '/sessions', to: 'sessions#destroy'
  end

end
