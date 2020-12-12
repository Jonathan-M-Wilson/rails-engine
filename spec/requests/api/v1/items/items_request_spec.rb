require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  describe "Items" do
    it "can get items" do
      merchant = create(:merchant)
      item = create_list(:item, 3, merchant_id: merchant.id)


      get "/api/v1/items"
      items_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items_json.class).to eq(Hash)
      expect(items_json[:data].size).to eq(3)
      expect(items_json[:data][0]).to have_key(:id)
      expect(items_json[:data][0]).to have_key(:type)
      expect(items_json[:data][0][:attributes]).to have_key(:name)
      expect(items_json[:data][0][:attributes]).to have_key(:description)
      expect(items_json[:data][0][:attributes]).to have_key(:unit_price)
      expect(items_json[:data][0][:attributes]).to have_key(:merchant_id)
    end

    it "can get an item by its id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end
  end
end
