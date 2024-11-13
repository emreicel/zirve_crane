Rails.application.routes.draw do
  # Devise user authentication
  devise_for :users

  # Health check and PWA routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path
  root to: "home#index"

  # Resources routes
  resources :cranes
  resources :customers
  resources :crane_owners
  resources :contracts do
    member do
      get :show_pdf
    end
  end
  resources :users, only: [:index, :new, :edit, :update]
  resources :payment_methods

  # Remove the following redundant GET routes as they are already covered by the resources
  # get "payment_methods/index"
  # get "payment_methods/new"
  # get "payment_methods/create"
  # get "payment_methods/edit"
  # get "payment_methods/update"
  # get "payment_methods/destroy"
  # get "users/index"
  # get "users/edit"
  # get "users/update"
  # get "contracts/new"
  # get "contracts/create"
  # get "contracts/index"
  # get "contracts/edit"
  # get "contracts/update"
  # get "contracts/destroy"
  # get "customers/new"
  # get "customers/create"
  # get "customers/index"
  # get "customers/edit"
  # get "customers/update"
  # get "customers/destroy"
  # get "cranes/new"
  # get "cranes/create"
  # get "cranes/index"

  # Manually added home route
  get "home/index"

end
