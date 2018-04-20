class Api::V1::ProductsController < Api::Base
  before_action :authenticate

  def index
    render json: Product.all.order(order).limit(limit).offset(offset)
  end


  def create
    p = Product.create!(product_params)
    render json: {success: true, product: p}
  end


  def update
    p = Product.find(params[:id])
    p.update!(product_params)
    render json: {success: true, product: p}

  end

  def destroy
    p = Product.find(params[:id])
    p.delete
    render json: {success: true, product: p}

  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :price
    )
  end
end
