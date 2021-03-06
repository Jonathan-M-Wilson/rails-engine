require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  it "can get a list of all the items belonging to a merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"
    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items_json.class).to eq(Hash)
    expect(items_json[:data].size).to eq(3)
    expect(items_json[:data][0]).to have_key(:id)
    expect(items_json[:data][0]).to have_key(:type)
    expect(items_json[:data][0][:attributes]).to have_key(:name)
  end
end
