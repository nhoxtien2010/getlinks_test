require 'rails_helper'
require 'faker'

module SessionsHelper
  def json_response
    JSON.parse(response.body)
  end

  def get_access_token
    post api_v1_users_login_path, params: {user: {email: "admin@example.com", password: "password"}}
    json_response['token']
  end

  def create_normal_user
    User.create(
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password',
    )
  end

  def login(user)
    post api_v1_users_login_path, params: {user: {email: user.email, password: "password"}}
    json_response['token']
  end

end
