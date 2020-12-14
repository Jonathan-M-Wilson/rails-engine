require 'rails_helper'

RSpec.describe 'Single Find feature' do
  it 'can search for an item by name, case insensitive or partial match' do
    item = create(:item, name: "unIque nAme")
    create_list(:item, 2)

    attribute = "name"
    query = "Ique"

    get "/api/v1/items/find?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.size).to eq(1)
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can search for an item by description, case insensitive, or partial match' do
    item = create(:item, description: "unique Description")
    create_list(:item, 2)

    attribute = "description"
    query = "ique"

    get "/api/v1/items/find?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.size).to eq(1)
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
  end

  it 'can search for an item by unit price' do
    item = create(:item, unit_price: 1234.56)
    create_list(:item, 2)

    attribute = "unit_price"

    get "/api/v1/items/find?#{attribute}=#{item.unit_price}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.size).to eq(1)
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:id]).to eq("#{item.id}")
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end

  it 'can search for an item by created_at' do
    item = create(:item, created_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")
    create(:item, created_at: "'Fri, 4 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "created_at"
    query = "3"

    get "/api/v1/items/find?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.size).to eq(1)
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:id]).to eq("#{item.id}")
  end

  it 'can search for an item by updated_at' do
    item = create(:item, updated_at: "'Fri, 3 Dec 2020 8:00:00 UTC +00:00'")
    create(:item, created_at: "'Fri, 4 Dec 2020 8:00:00 UTC +00:00'")

    attribute = "updated_at"
    query = "3"

    get "/api/v1/items/find?#{attribute}=#{query}"
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect(item_json.size).to eq(1)
    expect(item_json.class).to eq(Hash)
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:id]).to eq("#{item.id}")
  end
end
