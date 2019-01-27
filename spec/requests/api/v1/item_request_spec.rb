require "rails_helper"

describe "Items API" do

  it "gets a list of items" do
    create(:merchant, id: 1)
    create_list(:item, 3, merchant_id: 1)

    get '/api/v1/items.json'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "gets an item" do
    create(:merchant, id: 1)
    id = create(:item, merchant_id: 1).id

    get "/api/v1/items/#{id}.json"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find a item by id" do
    create(:merchant, id: 1)
    id = create(:item, merchant_id: 1).id

    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an item by name" do
    create(:merchant, id: 1)
    name = create(:item, merchant_id: 1).name

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find an item by description" do
    create(:merchant, id: 1)
    description = create(:item, merchant_id: 1).description

    get "/api/v1/items/find?description=#{description}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["description"]).to eq(description)
  end

  it "can find an item by unit_price" do
    create(:merchant, id: 1)
    unit_price = create(:item, merchant_id: 1).unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["unit_price"]).to eq(unit_price.to_s)
  end

  it "can find an item by merchant_id" do
    create(:merchant, id: 1)
    merchant_id = create(:item, merchant_id: 1).merchant_id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find an item by its created_at" do
    create(:merchant, id: 1)
    item = create(:item, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC")
    id = item.id
    created_at = item.created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an item by its updated_at" do
    create(:merchant, id: 1)
    item = create(:item, merchant_id: 1, updated_at: "2012-03-27 14:53:59 UTC")
    id = item.id
    updated_at = item.updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find all items by id" do
     create(:merchant, id: 1)
     item = create(:item, merchant_id: 1)
     id = item.id

     get "/api/v1/items/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(item["id"]).to eq(id)
  end

  it "can find all items by name" do
    create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1, name: "Baba")
    item_2 = create(:item, merchant_id: 1, name: "Baba")
    item_3 = create(:item, merchant_id: 1, name: "Baba")
    name = item_1.name

    get "/api/v1/items/find_all?name=#{name}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"][0]["attributes"]["name"]).to eq(name)
    expect(item["data"][1]["attributes"]["name"]).to eq(name)
    expect(item["data"][2]["attributes"]["name"]).to eq(name)
  end

  it "can find all items by description" do
    create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1, description: "Ankh Udja Seneb!")
    item_2 = create(:item, merchant_id: 1, description: "Ankh Udja Seneb!")
    item_3 = create(:item, merchant_id: 1, description: "Ankh Udja Seneb!")
    description = item_1.description

    get "/api/v1/items/find_all?description=#{description}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"][0]["attributes"]["description"]).to eq(description)
    expect(item["data"][1]["attributes"]["description"]).to eq(description)
    expect(item["data"][2]["attributes"]["description"]).to eq(description)
  end

  it "can find all items by unit_price" do
    create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1, unit_price: "9.80")
    item_2 = create(:item, merchant_id: 1, unit_price: "9.80")
    item_3 = create(:item, merchant_id: 1, unit_price: "9.80")
    unit_price = item_1.unit_price

    get "/api/v1/items/find_all?unit_price=#{unit_price}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"][0]["attributes"]["unit_price"]).to eq(unit_price.to_s)
    expect(item["data"][1]["attributes"]["unit_price"]).to eq(unit_price.to_s)
    expect(item["data"][2]["attributes"]["unit_price"]).to eq(unit_price.to_s)
  end

  it "can find all items by merchant_id" do
    create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1)
    item_2 = create(:item, merchant_id: 1)
    item_3 = create(:item, merchant_id: 1)
    merchant_id = item_1.merchant_id

    get "/api/v1/items/find_all?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"][0]["attributes"]["merchant_id"]).to eq(merchant_id)
    expect(item["data"][1]["attributes"]["merchant_id"]).to eq(merchant_id)
    expect(item["data"][2]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "returns a random item" do
    create(:merchant, id: 1)
    item = create(:item, merchant_id: 1)
    id = item.id

    get "/api/v1/items/random.json"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    allow(Item.all).to receive(:random).and_return(id)
  end

  it "returns a collection of invoice_items associated with an item" do
    merch = create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1)
    customer = create(:customer, id: 1)
    invoice = create(:invoice, id: 1, merchant_id: merch.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)

    get "/api/v1/items/#{item_1.id}/invoice_items"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["invoice_items"]["data"].count).to eq(3)
  end

  it "returns a merchant associated with an item" do
    merch = create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1)

    get "/api/v1/items/#{item_1.id}/merchant"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["merchant"]["data"]["id"]).to eq(merch.id.to_s)
  end
end