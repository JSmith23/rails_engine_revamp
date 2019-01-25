require 'rails_helper'

describe "Merchants API" do

  it "gets a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it "gets a merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find a merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find a merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find a merchant by its created_at" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id
    created_at = merchant.created_at

    get "/api/v1/merchants/find?created_at=#{created_at}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find a merchant by its updated_at" do
    merchant = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id
    updated_at = merchant.updated_at

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find all merchants by id" do
     merch = create(:merchant)
     id = merch.id

     get "/api/v1/merchants/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(merch["id"]).to eq(id)
  end

  it "can find all merchants by name" do
    merch_1 = create(:merchant, name: "Baba")
    merch_2 = create(:merchant, name: "Baba")
    merch_3 = create(:merchant, name: "Baba")
    name = merch_1.name

    get "/api/v1/merchants/find_all?name=#{name}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"][0]["attributes"]["name"]).to eq(name)
    expect(merchant["data"][1]["attributes"]["name"]).to eq(name)
    expect(merchant["data"][2]["attributes"]["name"]).to eq(name)
  end

  it "can find all merchants by created_at" do
    merch_1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    merch_2 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    merch_3 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    id_1 = merch_1.id
    id_2 = merch_2.id
    id_3 = merch_3.id
    created_at = merch_1.created_at

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"][0]["id"]).to eq(id_1.to_s)
    expect(merchant["data"][1]["id"]).to eq(id_2.to_s)
    expect(merchant["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "can find all merchants by updated_at" do
    merch_1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    merch_2 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    merch_3 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id_1 = merch_1.id
    id_2 = merch_2.id
    id_3 = merch_3.id
    updated_at = merch_1.updated_at

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"][0]["id"]).to eq(id_1.to_s)
    expect(merchant["data"][1]["id"]).to eq(id_2.to_s)
    expect(merchant["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "returns a random merchant" do
    merch = create(:merchant)
    id = merch.id

    get "/api/v1/merchants/random.json"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    allow(Merchant.all).to receive(:random).and_return(id)
  end

  it "returns a collection of items associated with a merchant" do
    merch = create(:merchant, id: 1)
    item_1 = create(:item, merchant_id: 1)
    item_2 = create(:item, merchant_id: 1)
    item_3 = create(:item, merchant_id: 1)

    get "/api/v1/merchants/#{merch.id}/items"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["items"]["data"].count).to eq(3)
  end

  it "returns a collection of invoices associated with a merchant" do
    merch = create(:merchant, id: 1)
    customer = create(:customer, id: 1)
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)

    get "/api/v1/merchants/#{merch.id}/invoices"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["invoices"]["data"].count).to eq(3)
  end
end