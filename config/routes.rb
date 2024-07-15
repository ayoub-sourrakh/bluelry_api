Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :products, only: [:create, :index, :show, :update, :destroy]
    end
  end
end
