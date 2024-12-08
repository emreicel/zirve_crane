Rails.application.routes.draw do
  get "banks/index"
  get "banks/new"
  get "banks/create"
  get "banks/edit"
  get "banks/update"
  get "banks/destroy"
  get "roles/index"
  get "roles/new"
  get "roles/create"
  get "roles/edit"
  get "roles/update"
  get "roles/destroy"
  get "payment_tables/update"
  # Devise user authentication
  devise_for :users, skip: [:registrations], controllers: {
    sessions: 'devise/sessions',
    passwords: 'devise/passwords'
  }

  # Health check and PWA routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # Müşteri bilgilerini almak için API endpoint'i
  get 'customers/:id/info', to: 'customers#info'
  get 'cranes/:id/info', to: 'cranes#info', as: 'crane_info'

  # Root path
  root to: "home#index"

  # Resources routes
  resources :cranes do
    collection do
      post :import
      get :download_template
    end
  end
  resources :customers
  resources :crane_owners
  resources :crane_fixings
  resources :banks
  resources :price_offers do
    member do
      get :show_pdf
    end
    resources :price_offer_details, only: [:create, :edit, :update, :destroy]
    collection do
      get :get_crane_info
    end
  end
  resources :contracts do
    member do
      get :show_pdf
      post :send_email
      post :upload_invoice
      patch :complete
    end
  end
  resources :users, only: [:index, :new, :edit, :create, :update, :destroy]
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
