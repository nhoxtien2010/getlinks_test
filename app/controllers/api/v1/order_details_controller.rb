class Api::V1::OrderDetailsController < Api::Base
  before_action :authenticate

  def index
    order_id = params[:order_id]
    order = Order.find_by_id(order_id)
    unless order
      render json: {success: false, error: 'Invalid Order'}, status: :bad_request
      return
    end
    render json: order.order_details
  end


  def create
    o = OrderDetail.create! order_detail_params
    render json: {success: true, order_detail: o}
  end


  def update
    o = OrderDetail.find_by_id(params[:id])
    unless o
      render json: {success: false, error: 'Invalid order detail'}, status: :bad_request
      return
    end
    o.update! order_detail_params
    render json: {success: true, order_detail: o}

  end

  def destroy
    o = OrderDetail.find_by_id(params[:id])
    unless o
      render json: {success: false, error: 'Invalid order detail'}, status: :bad_request
      return
    end
    o.delete
    render json: {success: true, order_detail: o}

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(
      :order_id,
      :product_id,
      :amount
    )
  end
end
