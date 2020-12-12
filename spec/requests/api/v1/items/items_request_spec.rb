require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  describe "Items" do
    it "Can get items" do
      merchant = create(:merchant)
      item = create_list(:item, 1, merchant_id: merchant.id)


      get "/api/v1/items"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items_json.class).to eq(Hash)
      expect(items_json[:data].size).to eq(1)
      expect(items_json[:data][0]).to have_key(:id)
      expect(items_json[:data][0]).to have_key(:type)
      expect(items_json[:data][0][:attributes]).to have_key(:name)
      expect(items_json[:data][0][:attributes]).to have_key(:description)
      expect(items_json[:data][0][:attributes]).to have_key(:unit_price)
      expect(items_json[:data][0][:attributes]).to have_key(:merchant_id)
    end
  end
end
