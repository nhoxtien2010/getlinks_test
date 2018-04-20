class Api::V1::OrdersController < Api::Base
  before_action :authenticate

  def index
    render json: Order.all.order(order).limit(limit).offset(offset)
  end


  def create
    o = Order.create!(product_params)
    render json: {success: true, order: o}
  end


  def update
    o = Order.find(params[:id])
    o.update!(product_params)
    render json: {success: true, order: o}

  end

  def destroy
    o = Order.find(params[:id])
    o.delete
    render json: {success: true, order: o}

  end

  private

  def product_params
    params.require(:order).permit(
      :name
    )
  end
end
