class Api::V1::UsersController < Api::Base
  before_action :authenticate, except: %i[create login]

  def create
    user = User.create!(user_params)
    render json: user
  rescue => ex
    render json: { success: false, errors: "Bad params"}, status: :bad_request
  end

  def update
    u = User.find(params[:id])
    u.update(user_params)
    render json: {success: true, product: p}

  end


  def login
    user = User.find_by_email(user_params[:email])
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
