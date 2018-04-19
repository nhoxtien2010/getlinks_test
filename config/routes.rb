Rails.application.routes.draw do
  active_admin_config = ActiveAdmin::Devise.config
  # active_admin_config[:controllers][:sessions] = 'sessions'

  devise_for :users, active_admin_config
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'


  namespace :api do
    namespace :v1 do
      resource :users, only: %i[create]
      post 'users/login'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
