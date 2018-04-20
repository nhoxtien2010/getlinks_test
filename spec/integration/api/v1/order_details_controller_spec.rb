require 'rails_helper'
require 'byebug'
require Rails.root.join('spec', 'helpers', 'sessions_helper_spec')
RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe 'Api::V1::OrderDetailsController', type: :request do

  before(:each) {
    @admin_user = create(:user)
    @order = create(:order)
    @product = create(:product)

    @order_detail = OrderDetail.create(order_id: @order.id, product_id: @product.id)

    @params = {
        order_detail: {
            order_id: @order.id,
            product_id: @product.id,
            amount: 1
        }
    }

  }

  describe 'index' do
    it 'should success' do
      order = create(:order)
      get( api_v1_order_details_path(order_id: order.id),
            headers: { 'HTTP_API_TOKEN' => get_access_token })

      expect(response).to have_http_status(:success)
      expect(json_response.length).to eq(0)

      normal_user = create_normal_user
      get( api_v1_order_details_path(order_id: @order.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) })
      expect(response).to have_http_status(:success)
      expect(json_response.length).to eq(1)

    end

    it 'should error' do
      get( api_v1_order_details_path)
      expect(response).to have_http_status(401)

      get( api_v1_order_details_path(order_id: 9999999),
           headers: { 'HTTP_API_TOKEN' => get_access_token })

      expect(response).to have_http_status(400)

    end
  end

  describe 'create' do
    it 'should success' do
      order = create(:order)
      product = create(:product)
      post( api_v1_order_details_path,
          headers: { 'HTTP_API_TOKEN' => get_access_token },
          params: @params
      )

      expect(response).to have_http_status(:success)

      normal_user = create_normal_user
      post( api_v1_order_details_path,
            headers: { 'HTTP_API_TOKEN' => login(normal_user) },
            params: @params
      )
      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      normal_user = create_normal_user
      post( api_v1_order_details_path,
        params: @params
      )

      expect(response).to have_http_status(401)

      @params[:order_detail][:order_id] = 99999
      post( api_v1_order_details_path,
          headers: { 'HTTP_API_TOKEN' => login(normal_user) },
          params: @params
      )
      expect(response).to have_http_status(400)

    end
  end

  describe 'update' do
    it 'should success' do
      put( api_v1_order_detail_path(id: @order_detail.id),
        headers: { 'HTTP_API_TOKEN' => get_access_token },
        params: @params
      )

      expect(response).to have_http_status(:success)

      normal_user = create_normal_user
      put( api_v1_order_detail_path(id: @order_detail.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: @params
      )
      expect(response).to have_http_status(:success)
      another_order = create(:order)
      @params[:order_detail][:order_id] = another_order.id
      put( api_v1_order_detail_path(id: @order_detail.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: @params
      )
      expect(response).to have_http_status(:success)

    end

    it 'should error' do
      normal_user = create_normal_user
      put( api_v1_order_detail_path(id: 999999),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: @params
      )
      expect(response).to have_http_status(400)

      put( api_v1_order_detail_path(id: @order_detail.id),
           params: @params
      )
      expect(response).to have_http_status(401)

      @params[:order_detail][:order_id] = 9999999
      put( api_v1_order_detail_path(id: @order_detail.id),
           headers: { 'HTTP_API_TOKEN' => login(normal_user) },
           params: @params
      )
      expect(response).to have_http_status(400)

    end
  end

  describe 'delete' do
    it 'should success' do
      delete( api_v1_order_detail_path(id: @order_detail.id),
           headers: { 'HTTP_API_TOKEN' => get_access_token },
      )

      expect(response).to have_http_status(:success)
      # expect(json_response['description']).to eq('sample description')
    end

    it 'should error' do
      delete api_v1_order_detail_path(id: @order_detail.id)
      expect(response).to have_http_status(401)

      delete( api_v1_order_detail_path(id: 999999),
        headers: { 'HTTP_API_TOKEN' => get_access_token })

      expect(response).to have_http_status(400)


    end
  end

end
