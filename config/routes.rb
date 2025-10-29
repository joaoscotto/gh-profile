Rails.application.routes.draw do
  resources :profiles, only: [ :index, :update, :create, :destroy ]

  root "profiles#index"
end
