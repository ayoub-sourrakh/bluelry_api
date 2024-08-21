Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        skip: :sessions
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      get 'users/me', to: 'users#me'
      resources :products, only: [:create, :index, :show, :update, :destroy]
      resources :users, only: [:index, :show, :me]
    end
  end
end
