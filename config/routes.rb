Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      get 'users/me', to: 'users#me'
      resources :products, only: [:create, :index, :show, :update, :destroy]
      resources :users, only: [:index, :show, :me]
      resource :cart, only: [:show] do
        post 'add_item', to: 'carts#add_item'
        delete 'remove_item', to: 'carts#remove_item'
        delete 'clear', to: 'carts#clear_cart'
      end
    end
  end
end
