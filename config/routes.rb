Rails.application.routes.draw do
  # Route pour le frontend React
  root 'home#index' # Redirige vers le contrôleur qui sert l'application React

  # Routes pour l'API versionnée
  namespace :api do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords], controllers: {
        sessions: 'api/v1/sessions'
      }

      # Autres routes de l'API ici, par exemple :
      resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # Route pour gérer toutes les autres requêtes non API et les rediriger vers React
  get '*path', to: 'home#index', constraints: ->(req) { req.path.exclude? 'api/v1' }
end
