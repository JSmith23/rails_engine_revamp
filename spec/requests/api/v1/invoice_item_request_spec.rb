require "rails_helper"

describe "Invoice Item API" do
  before :each do
    create(:customer, id: 1)
    create(:merchant, id: 1)
    create(:item, id: 1, merchant_id: 1)
    create(:invoice, id: 1, customer_id: 1, merchant_id: 1)
  end

  it "gets a list of invoice items" do
    create_list(:invoice_item, 3, item_id: 1, invoice_id: 1)

    get '/api/v1/invoice_items.json'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end

  it "gets an invoice item" do
    id = create(:invoice_item, item_id: 1, invoice_id: 1).id

    get "/api/v1/invoice_items/#{id}.json"
    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"]["id"]).to eq(id.to_s)
  end

  it "can find a invoice_item by id" do
    id = create(:invoice_item, item_id: 1, invoice_id: 1).id

    get "/api/v1/invoice_items/find?id=#{id}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice_item by item_id" do
    item_id = create(:invoice_item, item_id: 1, invoice_id: 1).item_id

    get "/api/v1/invoice_items/find?item_id=#{item_id}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_id)
  end

  it "can find an invoice_item by invoice_id" do
    invoice_id = create(:invoice_item, item_id: 1, invoice_id: 1).invoice_id

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find an invoice_item by quantity" do
    quantity = create(:invoice_item, item_id: 1, invoice_id: 1).quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(quantity)
  end

  it "can find an invoice_item by unit_price" do
    unit_price = create(:invoice_item, item_id: 1, invoice_id: 1).unit_price

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(unit_price.to_s)
  end

  it "can find an invoice_item by its created_at" do
    created_at = create(:invoice_item, item_id: 1, invoice_id: 1, created_at: "2012-03-27 14:53:59 UTC")
    id = created_at.id
    created_at = created_at.created_at

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice_item by its updated_at" do
    updated_at = create(:invoice_item, item_id: 1, invoice_id: 1, updated_at: "2012-03-27 14:53:59 UTC")
    id = updated_at.id
    updated_at = updated_at.updated_at

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "can find all invoice_items by id" do
     invoice_item = create(:invoice_item, item_id: 1, invoice_id: 1)
     id = invoice_item.id

     get "/api/v1/invoice_items/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(invoice_item["id"]).to eq(id)
  end

  it "can find all invoice items by item_id" do
    invoice_item_1 = create(:invoice_item, item_id: 1, invoice_id: 1)
    invoice_item_2 = create(:invoice_item, item_id: 1, invoice_id: 1)
    invoice_item_3 = create(:invoice_item, item_id: 1, invoice_id: 1)
    item_id = invoice_item_1.item_id

    get "/api/v1/invoice_items/find_all?item_id=#{item_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"][0]["attributes"]["item_id"]).to eq(item_id)
    expect(invoice_item["data"][1]["attributes"]["item_id"]).to eq(item_id)
    expect(invoice_item["data"][2]["attributes"]["item_id"]).to eq(item_id)
  end

  it "can find all invoice items by invoice_id" do
    invoice_item_1 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_2 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_3 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_id = invoice_item_1.invoice_id

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"][0]["attributes"]["invoice_id"]).to eq(invoice_id)
    expect(invoice_item["data"][1]["attributes"]["invoice_id"]).to eq(invoice_id)
    expect(invoice_item["data"][2]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find all invoice items by quantity" do
    invoice_item_1 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_2 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_3 = create(:invoice_item, invoice_id: 1, item_id: 1)
    quantity = invoice_item_1.quantity

    get "/api/v1/invoice_items/find_all?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"][0]["attributes"]["quantity"]).to eq(quantity)
    expect(invoice_item["data"][1]["attributes"]["quantity"]).to eq(quantity)
    expect(invoice_item["data"][2]["attributes"]["quantity"]).to eq(quantity)
  end

  xit "can find all invoice items by created_at" do
    invoice_item_1 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_2 = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_item_3 = create(:invoice_item, invoice_id: 1, item_id: 1)
    created_at = invoice_item_1.created_at
    id_1 = invoice_item_1.id
    id_2 = invoice_item_2.id
    id_3 = invoice_item_3.id

    get "/api/v1/invoice_items/find_all?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"][0]["id"]).to eq(id_1.to_s)
    expect(invoice_item["data"][1]["id"]).to eq(id_2.to_s)
    expect(invoice_item["data"][2]["id"]).to eq(id_3.to_s)
  end

  xit "can find all invoices by updated_at" do
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)
    updated_at = invoice_1.updated_at
    id_1 = invoice_1.id
    id_2 = invoice_2.id
    id_3 = invoice_3.id

    get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"][0]["id"]).to eq(id_1.to_s)
    expect(invoice["data"][1]["id"]).to eq(id_2.to_s)
    expect(invoice["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "returns a random invoice item" do
    invoice_item = create(:invoice_item, invoice_id: 1, item_id: 1)
    id = invoice_item.id

    get "/api/v1/invoice_items/random.json"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    allow(InvoiceItem.all).to receive(:random).and_return(id)
  end

  it "returns an item associated with an invoice item" do
    invoice_item = create(:invoice_item, invoice_id: 1, item_id: 1)
    item_id = invoice_item.item_id
    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["relationships"]["item"]["data"]["id"]).to eq(item_id.to_s)
  end

  it "returns an invoice associated with an invoice item" do
    invoice_item = create(:invoice_item, invoice_id: 1, item_id: 1)
    invoice_id = invoice_item.invoice_id
    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["relationships"]["invoice"]["data"]["id"]).to eq(invoice_id.to_s)
  end
end