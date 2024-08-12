Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create, :index, :show, :update, :destroy]

      devise_scope :user do
        post 'register', to: 'users/registrations#create'
      end
    end
  end
end
