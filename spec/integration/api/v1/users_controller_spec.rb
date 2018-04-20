require 'rails_helper'
require 'faker'
require Rails.root.join('spec', 'helpers', 'sessions_helper_spec')
RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe 'Api::V1::UsersController', type: :request do

  before(:each) {
    @admin_user = create(:user)
    @user = {
        email: 'aa@example.com',
        password: 'aa@example.com',
        password_confirmation: 'aa@example.com'
    }
  }
  describe 'create' do
    it 'should success' do

      post( api_v1_users_path,
        headers: { 'HTTP_API_TOKEN' => get_access_token },
        params: {
          user: @user
        }
      )

      expect(response).to have_http_status(:success)
      expect(json_response['email']).to eq(@user[:email])
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      @user[:password_confirmation] = 'fjslkdjflsjdl'
      post( api_v1_users_path,
            headers: { 'HTTP_API_TOKEN' => get_access_token },
            params: {
                user: @user
            }
      )

      expect(response).to have_http_status(400)
      @user.delete(:password)
      post( api_v1_users_path,
            headers: { 'HTTP_API_TOKEN' => get_access_token },
            params: {
                user: @user
            }
      )
      expect(response).to have_http_status(400)

    end


    describe 'update' do
      it "should success" do

        put( api_v1_user_path(id: @admin_user.id),
              headers: { 'HTTP_API_TOKEN' => get_access_token },
              params: {
                  user: @user
              }
        )

        expect(response).to have_http_status(:success)
      end

      it "should error" do

        put( api_v1_user_path(id: 99999999999),
             headers: { 'HTTP_API_TOKEN' => get_access_token },
             params: {
                 user: @user
             }
        )

        expect(response).to have_http_status(400)
      end
    end

  end

end
