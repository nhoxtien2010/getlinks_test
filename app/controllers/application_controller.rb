class ApplicationController < ActionController::Base
  before_action :role_authenticate
  SUPER_CONTROLLERS = %w[admin/users admin/products].freeze

  def role_authenticate
    if SUPER_CONTROLLERS.include?(params['controller']) && !current_user.admin?
      redirect_to new_user_session_path
    end
  end


  def order
    params[:order] || 'created_at'
  end

  def limit
    params[:limit] || 20
  end

  def page
    params[:page] || 1
  end

  def offset
    (page - 1) * limit
  end
end
