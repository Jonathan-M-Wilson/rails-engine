class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity].to_i))
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new(RevenueFacade.revenue(merchant.revenue))
  end
end
