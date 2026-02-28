Rails.application.routes.draw do
  # Dashboard
  root "dashboard#index"

  # Karyawan
  resources :employees

  # Cuti
  resources :leaves do
    member do
      patch :approve
      patch :reject
    end
  end

  # Absensi
  resources :attendances do
    collection do
      get :bulk_create
      post :bulk_create
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
