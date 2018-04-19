Rails.application.routes.draw do
  active_admin_config = ActiveAdmin::Devise.config
  active_admin_config[:controllers][:sessions] = 'sessions'

  devise_for :admin_users, active_admin_config
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'


  namespace :api do
    namespace :v1 do
      resource :admin_users, only: %i[create]
      post 'admin_users/login'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
