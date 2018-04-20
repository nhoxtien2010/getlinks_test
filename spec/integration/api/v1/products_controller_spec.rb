require 'rails_helper'
require 'byebug'
require Rails.root.join('spec', 'helpers', 'sessions_helper_spec')
RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe 'Api::V1::ProductsController', type: :request do

  before(:each) {
    @admin_user = create(:user)
    5.times do
      create(:product)
    end

  }

  describe 'index' do
    it 'should success' do
      get( api_v1_products_path,
            headers: { 'HTTP_API_TOKEN' => get_access_token })

      expect(response).to have_http_status(:success)
      expect(json_response.length).to eq(5)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      normal_user = create_normal_user

      get( api_v1_products_path)
      expect(response).to have_http_status(401)

      get( api_v1_products_path,
           headers: { 'HTTP_API_TOKEN' => login(normal_user) })
      expect(response).to have_http_status(200)
      expect(json_response.length).to eq(5)

    end
  end

  describe 'create' do
    it 'should success' do
      post( api_v1_products_path,
           headers: { 'HTTP_API_TOKEN' => get_access_token },
            params: {
                product: {
                    name: Faker::Name.name,
                    price: Faker::Number.number(3)
                }
            }
      )

      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      normal_user = create_normal_user
      post( api_v1_products_path,
        headers: { 'HTTP_API_TOKEN' => login(normal_user) },
        params: {
            product: {
                name: Faker::Name.name,
                price: Faker::Number.number(3)
            }
        }
      )

      expect(response).to have_http_status(401)
      expect(json_response['error']).to eq("You do not have role to do this action")

    end
  end

  describe 'update' do
    it 'should success' do
      sample_product = create(:product)
      put( api_v1_product_path(id: sample_product.id),
        headers: { 'HTTP_API_TOKEN' => get_access_token },
        params: {
          product: {
              name: Faker::Name.name,
              price: Faker::Number.number(3)
          }
        }
      )

      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      sample_product = create(:product)
      normal_user = create_normal_user
      put( api_v1_product_path(id: sample_product.id),
            headers: { 'HTTP_API_TOKEN' => login(normal_user) },
            params: {
                product: {
                    name: Faker::Name.name,
                    price: Faker::Number.number(3)
                }
            }
      )

      expect(response).to have_http_status(401)
      expect(json_response['error']).to eq("You do not have role to do this action")

    end
  end

  describe 'delete' do
    it 'should success' do
      sample_product = create(:product)
      delete( api_v1_product_path(id: sample_product.id),
           headers: { 'HTTP_API_TOKEN' => get_access_token },
           params: {
               product: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )

      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      sample_product = create(:product)
      normal_user = create_normal_user
      delete( api_v1_product_path(id: sample_product.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: {
               product: {
                   name: Faker::Name.name,
                   price: Faker::Number.number(3)
               }
           }
      )

      expect(response).to have_http_status(401)
      expect(json_response['error']).to eq("You do not have role to do this action")

    end
  end

end
