class Api::V1::AdminUsersController < Api::Base
  before_action :authenticate, except: :create
  
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
