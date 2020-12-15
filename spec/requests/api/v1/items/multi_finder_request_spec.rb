require 'rails_helper'

RSpec.describe 'Multi Find feature' do
  it 'can search for multiple items by name, case insensitive or partial match' do
    create_list(:item, 3, name: "unIque nAme")

    attribute = "name"
    query = "unI"

    get "/api/v1/items/find_all?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.class).to eq(Hash)
    expect(item_json[:data].size).to eq(3)
    expect(item_json[:data][0][:id]).to_not eq(item_json[:data][1][:id])
  end

  it 'can search for multiple items by description, case insensitive, or partial match' do
    create_list(:item, 3, description: "unique Description")

    attribute = "description"
    query = "ique"

    get "/api/v1/items/find_all?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.class).to eq(Hash)
    expect(item_json[:data].size).to eq(3)
    expect(item_json[:data][0][:id]).to_not eq(item_json[:data][1][:id])
  end

  it 'can search for multiple items by unit price' do
    create_list(:item, 3, unit_price: 1234.56)

    attribute = "unit_price"
    query = "1234"

    get "/api/v1/items/find_all?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.class).to eq(Hash)
    expect(item_json[:data].size).to eq(3)
    expect(item_json[:data][0][:id]).to_not eq(item_json[:data][1][:id])
  end

  it 'can search for multiple items by created_at' do
    create_list(:item, 3, created_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "created_at"
    query = "3"

    get "/api/v1/items/find_all?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.class).to eq(Hash)
    expect(item_json[:data].size).to eq(3)
    expect(item_json[:data][0][:id]).to_not eq(item_json[:data][1][:id])
  end

  it 'can search for multiple items by updated_at' do
    create_list(:item, 3, updated_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "updated_at"
    query = "3"

    get "/api/v1/items/find_all?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.class).to eq(Hash)
    expect(item_json[:data].size).to eq(3)
    expect(item_json[:data][0][:id]).to_not eq(item_json[:data][1][:id])
  end
end
