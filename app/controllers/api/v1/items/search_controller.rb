class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.search(permitted_params))
  end

  private

  def permitted_params
    params.permit(:name, :id, :unit_price, :description, :created_at, :updated_at, :merchant_id)
  end
end
