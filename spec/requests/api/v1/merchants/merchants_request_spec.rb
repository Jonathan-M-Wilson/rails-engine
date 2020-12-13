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

    it "can create a new merchant" do
      merchant_params = { name: "New Name" }

      post '/api/v1/merchants', params: merchant_params
      merchant_json = JSON.parse(response.body, symbolize_names: true)
      merchant = Merchant.last

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      expect(merchant_json.class).to eq(Hash)
      expect(merchant.name).to eq(merchant_params[:name])
      expect(merchant_json[:data][:type]).to eq('merchant')
      expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
      expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
    end

    it "can update an exisiting merchant" do
      merchant = create(:merchant)
      previous_name = merchant.name

      merchant_params = { name: "Random Name" }

      patch "/api/v1/merchants/#{merchant.id}", params: merchant_params
      updated_merchant = Merchant.find(merchant.id)
      merchant_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      expect(merchant_json.class).to eq(Hash)
      expect(updated_merchant.name).to_not eq(previous_name)
      expect(updated_merchant.name).to eq(merchant_params[:name])
      expect(merchant_json[:data][:type]).to eq('merchant')
      expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
      expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
    end
  end
end
