class Api::V1::AdminUsersController < Api::Base
  before_action :authenticate, except: %i[create login]

  def create
    user = AdminUser.create!(user_params)
    render json: user

  end


  def login
    user = AdminUser.find_by_email(user_params[:email])

    if user && user.validate(user_params[:password])
      render json: {success: true, token: user.authentication_token}
    else
      render json: {success: false, error: 'Wrong user email or password'}
    end

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
