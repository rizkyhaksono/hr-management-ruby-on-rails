Rails.application.routes.draw do
  root "dashboard#index"

  resources :employees
  resources :leaves do
    member do
      patch :approve
      patch :reject
    end
  end
  resources :attendances do
    collection do
      get :bulk_create
      post :bulk_create
      get :calendar
    end
  end

  resources :reports, only: [:index]
  get "search", to: "search#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
