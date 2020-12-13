require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  describe "Merchants" do
    it "can get merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants"
      merchants_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      expect(merchants_json.class).to eq(Hash)
      expect(merchants_json[:data].size).to eq(3)
      expect(merchants_json[:data][0]).to have_key(:id)
      expect(merchants_json[:data][0]).to have_key(:type)
      expect(merchants_json[:data][0]).to have_key(:attributes)
      expect(merchants_json[:data][0][:attributes]).to have_key(:name)
    end

    it "can get a merchant by its id" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"
      merchant_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")
      
      expect(merchant_json.class).to eq(Hash)
      expect(merchant_json[:data].size).to eq(3)
      expect(merchant_json[:data][:type]).to eq('merchant')
      expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
      expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
    end
  end
end
