class Api::V1::AdminUsersController < Api::Base
  before_action :authenticate, except: :create
  swagger_controller :admin_users, "AdminUsers"

  swagger_api :create do
    summary "Post to create new user"
    param :form, 'user[email]', :string, :required, "email"
    param :form, 'user[password]', :string, :required, "password"
    param :form, 'user[password_confirmation]', :string, :required, "password confirmation"
    response :not_acceptable
  end


  def create
    user = AdminUser.create!(user_params)
    render json: user

  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
