Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get "admin_dashboard/index"
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses do
    resources :submissions
  end
  resources :coding_classes
  resources :trimesters, only: [:edit, :update]
  
  get "/trimesters", to: "trimesters#index"
  get "/trimesters/:id", to: "trimesters#show"
  get "/dashboard", to: "admin_dashboard#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :courses, only: [:index] do
        resources :enrollments, only: [:index]
      end

      namespace :current_trimester do
        resources :enrollments, only: [:index], controller: "api/v1/enrollments"
      end

      resources :students, only: [:create]
    end
  end
end
