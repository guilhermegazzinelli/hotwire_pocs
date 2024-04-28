Rails.application.routes.draw do
  root to: "users#new"

  resources :users, only: [:new, :create]

  namespace :address do
    resources :via_cep, only: [:show], param: :zip_code, format: :json
  end
end
