class Api::V1::AnchorPurposesController < Api::Base
  before_action :authenticate

  def create
    ap = AnchorPurpose.create!(purpose_params)
    render json: ap
  end

  def index
    render json: AnchorPurpose.all
  end

  private

  def purpose_params
    params.require(:anchor_purpose).permit(
      :description
    )
  end
end
