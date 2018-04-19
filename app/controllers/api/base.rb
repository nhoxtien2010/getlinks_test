class Api::Base < ApplicationController
  STATUS = "status".freeze
  MESSAGE = "message".freeze
  DATA = "data".freeze

  def authenticate
    if current_user.blank?
      response = {}
      response[STATUS] = :error
      response[MESSAGE] = I18n.t("api.authentication_required")
      response[DATA] = nil
      render json: response, status: :unauthorized
    else
    #   continue
    end
  end

  def current_user
    if (api_token = token_param).present?
      @current_user ||= User.where(authentication_token: api_token).first
      @current_user
    end
  end

private

  def token_param
    request.headers["HTTP_API_TOKEN"] || params[:api_token]
  end

end