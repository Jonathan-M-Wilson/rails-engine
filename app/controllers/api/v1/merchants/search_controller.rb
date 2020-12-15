class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_merchant(permitted_params))
  end

  private

  def permitted_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
