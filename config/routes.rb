Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      # Autres routes API
      resources :products, only: [:create, :index, :show, :update, :destroy]
      # Ajoute ici les autres ressources que tu veux gérer via l'API
    end
  end
end
