require 'rails_helper'

RSpec.describe 'Multi Find feature' do
  it 'can search for multiple merchants by name, case insensitive or partial match' do
    create_list(:merchant, 3, name: "unIque nAme")

    attribute = "name"
    query = "Ique"

    get "/api/v1/merchants/find_all?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data].size).to eq(3)
    expect(merchant_json[:data][0][:id]).to_not eq(merchant_json[:data][1][:id])
  end

  it 'can search for multiple merchants by id' do
    create(:merchant, id: 123)
    create(:merchant, id: 124)
    create(:merchant, id: 125)

    attribute = "id"
    query = "12"

    get "/api/v1/merchants/find_all?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data].size).to eq(3)
    expect(merchant_json[:data][0][:id]).to_not eq(merchant_json[:data][1][:id])
  end

  it 'can search for multiple merchants by created_at' do
    create_list(:merchant, 3, created_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")


    attribute = "created_at"
    query = "3"

    get "/api/v1/merchants/find_all?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data].size).to eq(3)
    expect(merchant_json[:data][0][:id]).to_not eq(merchant_json[:data][1][:id])
  end

  it 'can search for multiple merchants by updated_at' do
    create_list(:merchant, 3, updated_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "updated_at"
    query = "3"

    get "/api/v1/merchants/find_all?#{attribute}=#{query}"
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(merchant_json.class).to eq(Hash)
    expect(merchant_json[:data].size).to eq(3)
    expect(merchant_json[:data][0][:id]).to_not eq(merchant_json[:data][1][:id])
  end
end
