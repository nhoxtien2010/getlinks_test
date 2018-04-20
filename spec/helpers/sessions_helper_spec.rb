require 'rails_helper'

module SessionsHelper
  def json_response
    JSON.parse(response.body)
  end

  def get_access_token
    post api_v1_users_login_path, params: {user: {email: "admin@example.com", password: "password"}}
    json_response['token']
  end

end
