Rails.application.routes.draw do
  namespace :address do
    resources :via_cep, only: [:show], param: :zip_code, format: :json
  end
end
