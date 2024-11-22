Rails.application.routes.draw do
  get "roles/index"
  get "roles/new"
  get "roles/create"
  get "roles/edit"
  get "roles/update"
  get "roles/destroy"
  get "payment_tables/update"
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
      post :send_email
      post :upload_invoice
    end
  end
  resources :users, only: [:index, :new, :edit, :create, :update]
  resources :roles
  resources :payment_methods
  resources :payment_tables do
    member do
      post :upload_invoice
      delete 'delete_file', to: 'payment_tables#delete_file'
      post :send_payment_email
    end
  end

  # Manually added home route
  get "home/index"

end
