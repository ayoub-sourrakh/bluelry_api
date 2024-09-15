Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Devise routes for user registration and sessions
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      # Route for getting user info
      get 'users/me', to: 'users#me'

      # Route for logging out
      devise_scope :user do
        delete 'users/sign_out', to: 'users/sessions#destroy'
      end

      # Product routes
      resources :products, only: [:create, :index, :show, :update, :destroy]

      # User management routes
      resources :users, only: [:index, :show]

      # Cart routes
      resource :cart, only: [:show] do
        post 'add_item', to: 'carts#add_item'
        delete 'remove_item', to: 'carts#remove_item'
        delete 'clear', to: 'carts#clear_cart'
      end

      # Order routes
      resources :orders, only: [:create, :index, :show]

      # Payment intent route
      post 'create-payment-intent', to: 'payments#create_payment_intent'
    end
  end
end
