Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
  get '/*path', to: 'dashboard#index'
end
