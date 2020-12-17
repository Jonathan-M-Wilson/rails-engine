require 'rails_helper'

describe "Merchants with most revenue" do
  it "returns the merchants with the most revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1, unit_price: 38.47)
    item_2 = create(:item, merchant: merchant_2, unit_price: 12.99)
    item_3 = create(:item, merchant: merchant_3, unit_price: 13.70)

    invoice_1 = create(:invoice, merchant: merchant_1, status: 'shipped')
    invoice_2 = create(:invoice, merchant: merchant_1, status: 'packaged')
    invoice_3 = create(:invoice, merchant: merchant_2, status: 'shipped')
    invoice_4 = create(:invoice, merchant: merchant_3, status: 'shipped')

    invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: item_1.unit_price, quantity: 30)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: item_1.unit_price, quantity: 54)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: item_2.unit_price, quantity: 21)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_3, unit_price: item_3.unit_price, quantity: 11)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    most_revenue_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    response.content_type == "application/json"

    expect(most_revenue_json[:data].size).to eq(2)
    expect(most_revenue_json[:data][0]).to have_key(:id)
    expect(most_revenue_json[:data][0]).to have_key(:type)
    expect(most_revenue_json[:data][0]).to have_key(:attributes)
    expect(most_revenue_json[:data][0][:attributes]).to have_key(:name)

    expect(most_revenue_json[:data][0][:attributes][:name]).to eq(merchant_1.name)
    expect(most_revenue_json[:data][1][:attributes][:name]).to eq(merchant_2.name)
  end
end
