Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/signup", to: "sessions#signup"
      post "auth/login",  to: "sessions#login"

      resources :expenses, only: %i[index show create update]
      resources :documents, only: [:create, :show]
      resources :invoices, only: %i[index show create update] do
        member do
          post :issue   # optional future endpoint to lock number/series
          post :mark_paid
          post :cancel
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
