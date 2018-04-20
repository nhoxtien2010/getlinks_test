class ApplicationController < ActionController::Base
  before_action :role_authenticate
  # SUPER_CONTROLLERS = %w[admin/users admin/products api/v1/products].freeze

  def role_authenticate
    if admin_action &&  !current_user.admin?
      if params['controller'].include? 'admin'
        redirect_to new_user_session_path
      else
        render json: {success: false, error: 'You do not have role to do this action'}, status: :unauthorized
      end
    end
  end


  def admin_action
    controller = params['controller'].to_s
    (controller.include?('users') || controller.include?('products')) && params['action'] != 'index'
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
