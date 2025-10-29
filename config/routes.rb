Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles, only: [ :index, :update, :create, :destroy ]

  root "profiles#index"
end
