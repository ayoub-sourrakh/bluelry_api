Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Devise routes pour l'authentification
      devise_for :users, skip: [:passwords], controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      # Routes pour d'autres ressources de l'API
      resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
