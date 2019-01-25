require 'rails_helper'

describe "Merchants API" do

  it "gets a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful
    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(3)
  end

  it "gets a customer" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"
    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can find a customer by id" do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can find a customer by name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find a customer by last_name" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find a customer by its created_at" do
    customer = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
    id = customer.id
    created_at = customer.created_at

    get "/api/v1/customers/find?created_at=#{created_at}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can find a customer by its updated_at" do
    customer = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
    id = customer.id
    updated_at = customer.updated_at

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can find all customers by id" do
     customer = create(:customer)
     id = customer.id

     get "/api/v1/customers/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(customer["id"]).to eq(id)
  end

  it "can find all customers by first name" do
    customer_1 = create(:customer, first_name: "Baba")
    customer_2 = create(:customer, first_name: "Baba")
    customer_3 = create(:customer, first_name: "Baba")
    name = customer_1.first_name

    get "/api/v1/customers/find_all?name=#{name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"][0]["attributes"]["first_name"]).to eq(name)
    expect(customer["data"][1]["attributes"]["first_name"]).to eq(name)
    expect(customer["data"][2]["attributes"]["first_name"]).to eq(name)
  end

  it "can find all customers by last name" do
    customer_1 = create(:customer, last_name: "Heru")
    customer_2 = create(:customer, last_name: "Heru")
    customer_3 = create(:customer, last_name: "Heru")
    last_name = customer_1.last_name

    get "/api/v1/customers/find_all?last_name=#{last_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"][0]["attributes"]["last_name"]).to eq(last_name)
    expect(customer["data"][1]["attributes"]["last_name"]).to eq(last_name)
    expect(customer["data"][2]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find all customers by created_at" do
    customer_1 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
    customer_2 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
    customer_3 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
    id_1 = customer_1.id
    id_2 = customer_2.id
    id_3 = customer_3.id
    created_at = customer_1.created_at

    get "/api/v1/customers/find_all?created_at=#{created_at}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"][0]["id"]).to eq(id_1.to_s)
    expect(customer["data"][1]["id"]).to eq(id_2.to_s)
    expect(customer["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "can find all customers by updated_at" do
    customer_1 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
    customer_2 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
    customer_3 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
    id_1 = customer_1.id
    id_2 = customer_2.id
    id_3 = customer_3.id
    updated_at = customer_1.updated_at

    get "/api/v1/customers/find_all?updated_at=#{updated_at}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"][0]["id"]).to eq(id_1.to_s)
    expect(customer["data"][1]["id"]).to eq(id_2.to_s)
    expect(customer["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "returns a random customer" do
    customer = create(:customer)
    id = customer.id

    get "/api/v1/customers/random.json"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    allow(Customer.all).to receive(:random).and_return(id)
  end

  it "returns a collection of invoices associated with a customer" do
    customer = create(:customer, id: 1)
    merch = create(:merchant, id: 1)
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: customer.id)

    get "/api/v1/merchants/#{merch.id}/invoices"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["invoices"]["data"].count).to eq(3)
  end

  it "returns a collection of transactions associated with a customer" do
    merch = create(:merchant, id: 1)
    customer = create(:customer, id: 1)
    invoice_1 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_2 = create(:invoice, merchant_id: 1, customer_id: 1)
    invoice_3 = create(:invoice, merchant_id: 1, customer_id: 1)

    get "/api/v1/customers/#{merch.id}/transactions"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["relationships"]["transactions"]["data"].count).to eq(3)
  end
end