require 'rails_helper'

describe "Revenue for merchant" do
  it "returns the revenue for a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1, unit_price: 38.47)
    item_2 = create(:item, merchant: merchant_1, unit_price: 7.12)
    item_3 = create(:item, merchant: merchant_2, unit_price: 12.99)

    invoice_1 = create(:invoice, merchant: merchant_1, status: 'shipped')
    invoice_2 = create(:invoice, merchant: merchant_1, status: 'shipped')
    invoice_3 = create(:invoice, merchant: merchant_2, status: 'shipped')

    invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: item_1.unit_price, quantity: 30)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: item_2.unit_price, quantity: 54)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3, unit_price: item_3.unit_price, quantity: 2)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)

    ii1_total = (invoice_item_1.quantity * invoice_item_1.unit_price)
    ii2_total = (invoice_item_2.quantity * invoice_item_2.unit_price)

    expected_amount = (ii1_total + ii2_total)

    query = merchant_1.id

    get "/api/v1/merchants/#{query}/revenue"
    revenue_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    response.content_type == "application/json"

    expect(revenue_json[:data].size).to eq(3)
    expect(revenue_json[:data]).to have_key(:id)
    expect(revenue_json[:data]).to have_key(:type)
    expect(revenue_json[:data]).to have_key(:attributes)
    expect(revenue_json[:data][:attributes]).to have_key(:revenue)
    expect(revenue_json[:data][:attributes][:revenue]).to eq(expected_amount)
  end
end
