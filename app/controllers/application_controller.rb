class ApplicationController < ActionController::Base
  before_action :role_authenticate
  SUPER_CONTROLLERS = %w[admin/users admin/products].freeze

  def role_authenticate
    if SUPER_CONTROLLERS.include?(params['controller']) && !current_user.admin?
      redirect_to new_user_session_path
    end
  end
end
