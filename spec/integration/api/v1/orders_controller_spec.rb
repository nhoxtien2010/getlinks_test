require 'rails_helper'
require 'byebug'
require Rails.root.join('spec', 'helpers', 'sessions_helper_spec')
RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe 'Api::V1::OrdersController', type: :request do

  before(:each) {
    @admin_user = create(:user)
    5.times do
      create(:order)
    end

  }

  describe 'index' do
    it 'should success' do
      get( api_v1_orders_path,
            headers: { 'HTTP_API_TOKEN' => get_access_token })

      expect(response).to have_http_status(:success)
      expect(json_response.length).to eq(5)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      normal_user = create_normal_user

      get( api_v1_orders_path)
      expect(response).to have_http_status(401)

      get( api_v1_orders_path,
           headers: { 'HTTP_API_TOKEN' => login(normal_user) })
      expect(response).to have_http_status(200)
      expect(json_response.length).to eq(5)

    end
  end

  describe 'create' do
    it 'should success' do
      post( api_v1_orders_path,
           headers: { 'HTTP_API_TOKEN' => get_access_token },
            params: {
                order: {
                    name: Faker::Name.name,
                    price: Faker::Number.number(3)
                }
            }
      )

      expect(response).to have_http_status(:success)

      normal_user = create_normal_user
      post( api_v1_orders_path,
            headers: { 'HTTP_API_TOKEN' => login(normal_user) },
            params: {
                order: {
                    name: Faker::Name.name,
                    price: Faker::Number.number(3)
                }
            }
      )
      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      post( api_v1_orders_path,
        params: {
            order: {
                name: Faker::Name.name,
                price: Faker::Number.number(3)
            }
        }
      )

      expect(response).to have_http_status(401)

    end
  end

  describe 'update' do
    it 'should success' do
      sample_order = create(:order)
      put( api_v1_order_path(id: sample_order.id),
        headers: { 'HTTP_API_TOKEN' => get_access_token },
        params: {
          order: {
              name: Faker::Name.name,
              price: Faker::Number.number(3)
          }
        }
      )

      expect(response).to have_http_status(:success)

      sample_order = create(:order)
      normal_user = create_normal_user
      put( api_v1_order_path(id: sample_order.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: {
               order: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )
      expect(response).to have_http_status(:success)

      put( api_v1_order_path(id: 999999),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: {
               order: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )
      expect(response).to have_http_status(400)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      sample_order = create(:order)
      put( api_v1_order_path(id: sample_order.id),
            params: {
                order: {
                    name: Faker::Name.name,
                    price: Faker::Number.number(3)
                }
            }
      )

      expect(response).to have_http_status(401)

    end
  end

  describe 'delete' do
    it 'should success' do
      sample_order = create(:order)
      delete( api_v1_order_path(id: sample_order.id),
           headers: { 'HTTP_API_TOKEN' => get_access_token },
           params: {
               order: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )

      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      sample_order = create(:order)
      delete( api_v1_order_path(id: sample_order.id),
           params: {
               order: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )

      expect(response).to have_http_status(401)

      delete( api_v1_order_path(id: 999999999),
              headers: { 'HTTP_API_TOKEN' => get_access_token },
              params: {
                  order: {
                      name: Faker::Name.name,
                      price: Faker::Number.number(3)
                  }
              }
      )
      expect(response).to have_http_status(400)

    end
  end

end
