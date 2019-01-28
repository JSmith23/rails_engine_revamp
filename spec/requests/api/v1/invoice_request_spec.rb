require "rails_helper"

describe "Invoice API" do
  before :each do
    create(:customer, id: 1)
    create(:merchant, id: 1)
  end

  it "gets a list of invoices" do
    create_list(:invoice, 3, merchant_id: 1, customer_id: 1)

    get '/api/v1/invoices.json'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "gets an invoice" do
    id = create(:invoice, merchant_id: 1, customer_id: 1).id

    get "/api/v1/invoices/#{id}.json"
    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "can find a invoice by id" do
    id = create(:invoice, merchant_id: 1, customer_id: 1).id

    get "/api/v1/invoices/find?id=#{id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice by merchant_id" do
    merchant_id = create(:invoice, merchant_id: 1, customer_id: 1).merchant_id

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find an invoice by customer_id" do
    customer_id = create(:invoice, merchant_id: 1, customer_id: 1).customer_id

    get "/api/v1/invoices/find?customer_id=#{customer_id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_id)
  end

  it "can find an invoice by status" do
    status = create(:invoice, merchant_id: 1, customer_id: 1).status

    get "/api/v1/invoices/find?status=#{status}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["attributes"]["status"]).to eq(status)
  end

  it "can find an invoice by its created_at" do
    created_at = create(:invoice, merchant_id: 1, customer_id: 1, created_at: "2012-03-27 14:53:59 UTC")
    id = created_at.id
    created_at = created_at.created_at

    get "/api/v1/invoices/find?created_at=#{created_at}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice by its updated_at" do
    updated_at = create(:invoice, merchant_id: 1, customer_id: 1, updated_at: "2012-03-27 14:53:59 UTC")
    id = updated_at.id
    updated_at = updated_at.updated_at

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "can find all invoices by id" do
     invoice = create(:invoice, merchant_id: 1, customer_id: 1)
     id = invoice.id

     get "/api/v1/invoices/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(invoice["id"]).to eq(id)
  end

  it "can find all invoices by customer_id" do
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)
    customer_id = invoice_1.customer_id

    get "/api/v1/invoices/find_all?customer_id=#{customer_id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"][0]["attributes"]["customer_id"]).to eq(customer_id)
    expect(invoice["data"][1]["attributes"]["customer_id"]).to eq(customer_id)
    expect(invoice["data"][2]["attributes"]["customer_id"]).to eq(customer_id)
  end

  it "can find all invoices by merchant_id" do
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)
    merchant_id = invoice_1.merchant_id

    get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"][0]["attributes"]["merchant_id"]).to eq(merchant_id)
    expect(invoice["data"][1]["attributes"]["merchant_id"]).to eq(merchant_id)
    expect(invoice["data"][2]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find all invoices by status" do
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)
    status = invoice_1.status

    get "/api/v1/invoices/find_all?status=#{status}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"][0]["attributes"]["status"]).to eq(status)
    expect(invoice["data"][1]["attributes"]["status"]).to eq(status)
    expect(invoice["data"][2]["attributes"]["status"]).to eq(status)
  end

  it "can find all invoices by created_at" do
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)
    created_at = invoice_1.created_at
    id_1 = invoice_1.id
    id_2 = invoice_2.id
    id_3 = invoice_3.id

    get "/api/v1/invoices/find_all?created_at=#{created_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"][0]["id"]).to eq(id_1.to_s)
    expect(invoice["data"][1]["id"]).to eq(id_2.to_s)
    expect(invoice["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "can find all invoices by updated_at" do
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

  it "returns a random invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    id = invoice.id

    get "/api/v1/invoices/random.json"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    allow(Invoice.all).to receive(:random).and_return(id)
  end

  it "returns a collection of invoice_items associated with an invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    item_1 = create(:item, merchant_id: 1)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["relationships"]["invoice_items"]["data"].count).to eq(3)
  end

  it "returns a merchant associated with an invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    merch_id = invoice.merchant_id
    get "/api/v1/invoices/#{invoice.id}/merchants"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["relationships"]["merchant"]["data"]["id"]).to eq(merch_id.to_s)
  end

  it "returns a customer associated with an invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    customer_id = invoice.customer_id
    get "/api/v1/invoices/#{invoice.id}/customers"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["relationships"]["customer"]["data"]["id"]).to eq(customer_id.to_s)
  end

  it "returns a collection of items associated with an invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    item_1 = create(:item, merchant_id: 1)
    item_2 = create(:item, merchant_id: 1)
    item_3 = create(:item, merchant_id: 1)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["relationships"]["items"]["data"].count).to eq(3)
  end

  it "returns a collection of transactions associated with an invoice" do
    invoice = create(:invoice, merchant_id: 1, customer_id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice.id)
    transaction_2 = create(:transaction, invoice_id: invoice.id)
    transaction_3 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["relationships"]["transactions"]["data"].count).to eq(3)
  end
end