require 'rails_helper'

RSpec.describe 'Single Find feature' do
  it 'can search for a merchant by name, case insensitive or partial match' do
    merchant = create(:merchant, name: "unIque nAme")
    create_list(:merchant, 2)

    attribute = "name"
    query = "Ique"

    get "/api/v1/merchants/find?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.size).to eq(1)
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can search for a merchant by id' do
    merchant = create(:merchant)
    create_list(:merchant, 2)

    attribute = "id"
    query = "#{merchant.id}"

    get "/api/v1/merchants/find?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.size).to eq(1)
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can search for a merchant by created_at' do
    merchant = create(:merchant, created_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")
               create(:merchant, created_at: "'Fri, 4 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "created_at"
    query = "3"

    get "/api/v1/merchants/find?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.size).to eq(1)
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can search for a merchant by updated_at' do
    merchant = create(:merchant, updated_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")
               create(:merchant, updated_at: "'Fri, 4 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "updated_at"
    query = "3"

    get "/api/v1/merchants/find?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.size).to eq(1)
    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data][:type]).to eq('merchant')
    expect(merchant_json[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
