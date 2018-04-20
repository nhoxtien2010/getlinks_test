class Api::V1::OrderDetailsController < Api::Base
  before_action :authenticate

  def index
    order_id = params[:order_id]
    order = Order.find(order_id)
    render json: order.order_details

  end


  def create
    o = OrderDetail.create! order_detail_params
    render json: {success: true, order_detail: o}
  end


  def update
    o = OrderDetail.find(params[:id])
    o.update! order_detail_params
    render json: {success: true, order_detail: o}

  end

  def destroy
    o = OrderDetail.find(params[:id])
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
