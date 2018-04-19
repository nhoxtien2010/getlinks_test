Rails.application.routes.draw do
  devise_for :users,  ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      post 'users/login'

      resources :order_details, only: %i[index create update destroy]
      resources :orders, only: %i[index create update destroy]
      resources :products, only: %i[index create update destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
