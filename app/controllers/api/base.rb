class Api::Base < ApplicationController
  STATUS = "status".freeze
  MESSAGE = "message".freeze
  DATA = "data".freeze

  def authenticate
    if current_login.blank?
      response = {}
      response[STATUS] = :error
      response[MESSAGE] = I18n.t("api.authentication_required")
      response[DATA] = nil
      render json: response, status: :unauthorized
    else
      render json: {email: @current_user.email, authentication_token: }
    end
  end

  def current_login
    if (api_token = token_param).present?
      @current_user ||= AdminUser.where(authentication_token: api_token).first
    end
  end

private

  def token_param
    request.headers["HTTP_API_TOKEN"] || params[:api_token]
  end

end