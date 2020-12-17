class Api::V1::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer.new(RevenueFacade.revenue_by_date(params[:start], params[:end]))
  end
end
