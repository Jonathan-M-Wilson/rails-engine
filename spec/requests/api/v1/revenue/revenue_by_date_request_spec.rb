require 'rails_helper'

describe "Revenue by date" do
  it "returns the revenue across all merchants between given dates" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)

    invoice_1 = create(:invoice, merchant: merchant_1, status: 'shipped')
    invoice_2 = create(:invoice, merchant: merchant_2, status: 'shipped')
    invoice_3 = create(:invoice, merchant: merchant_3, status: 'shipped')
    invoice_4 = create(:invoice, merchant: merchant_1, status: 'packaged')

    invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 12.99, quantity: 30)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: 12.99, quantity: 54)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 27.34, quantity: 21)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_3, unit_price: 68.00, quantity: 11)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    start_date = "2020-12-12"
    end_date = "2020-12-17"

    get "/api/v1/revenue?start=#{start_date}&end=#{end_date}"
    revenue_by_date_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    response.content_type == "application/json"

    expect(revenue_by_date_json[:data].size).to eq(3)
    expect(revenue_by_date_json[:data]).to have_key(:id)
    expect(revenue_by_date_json[:data]).to have_key(:type)
    expect(revenue_by_date_json[:data]).to have_key(:attributes)
    expect(revenue_by_date_json[:data][:attributes]).to have_key(:revenue)
    expect(revenue_by_date_json[:data][:attributes][:revenue]).to eq(1665.3)
  end
end
