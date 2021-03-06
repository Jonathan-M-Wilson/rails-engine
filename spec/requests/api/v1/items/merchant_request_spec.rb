require 'rails_helper'

RSpec.describe 'Item Merchant API' do
  it "can find an item's merchant" do
    item = create(:item)


    get "/api/v1/items/#{item.id}/merchants"
    merchant_json = JSON.parse(response.body, symbolize_names: true)
    merchant = item.merchant

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
