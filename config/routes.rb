require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.role == 'admin' } do
    resources :parking_slots
    resources :vehicle_models
    resources :payment_types

    # Defines specific route
    get 'customers', to: 'users#users'
    post 'search', to: 'search#index', as: 'search'

    # Defines api route
    get 'api/booked_per_day', to: 'home#booked_per_day'
    get 'api/revenue', to: 'home#revenue_data_for_last_7_days'
    get 'api/vehicle_model_distribution', to: 'home#vehicle_model_distribution'
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticate :user do 
    # Defines route
    root "home#index"
    resources :vehicles
    resources :vehicle_models, only: [:index]
    resources :bookings
    resources :parking_slots, only: [:index, :update]
    resources :payments
    resources :profiles

    # Defines specific route
    get 'settings', to: 'settings#profile'
    get 'settings/security', to: 'settings#security'

    # Defines api route
    get 'chart_data', to: 'home#chart_data'
    get 'parking_data', to: 'home#parking_data'
    
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :users
end
