require "rails_helper"

describe "Transaction API" do
  before :each do
    customer = create(:customer, id: 1)
    merchant = create(:merchant, id: 1)
    invoice = create(:invoice, id: 1, merchant_id: 1, customer_id: 1)
  end

  it "gets a list of transactions" do
    create_list(:transaction, 3, invoice_id: 1)

    get '/api/v1/transactions.json'

    expect(response).to be_successful
    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end

  it "gets a transaction" do
    id = create(:transaction, invoice_id: 1).id

    get "/api/v1/transactions/#{id}.json"
    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["id"]).to eq(id.to_s)
  end

  it "can find a transaction by id" do
    id = create(:transaction, invoice_id: 1).id

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["id"]).to eq(id.to_s)
  end

  it "can find an transaction by invoice_id" do
    invoice_id = create(:transaction, invoice_id: 1).invoice_id

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find an transaction by result" do
    result = create(:transaction, invoice_id: 1).result

    get "/api/v1/transactions/find?result=#{result}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["result"]).to eq(result)
  end

  it "can find an transaction by credit_card_number" do
    credit_card_number = create(:transaction, invoice_id: 1).credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(credit_card_number)
  end

  it "can find an transaction by credit_card_expiration_date" do
    create(:transaction, invoice_id: 1)
    credit_card_expiration_date = "2019-01-22"
    get "/api/v1/transactions/find?credit_card_expiration_date=#{credit_card_expiration_date}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["credit_card_expiration_date"]).to eq(credit_card_expiration_date)
  end

  it "can find a transaction by updated_at" do
    updated_at = create(:transaction, invoice_id: 1, updated_at: "2012-03-27T14:54:09.000Z")
    id = updated_at.id
    updated_at = updated_at.updated_at
    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["id"]).to eq(id.to_s)
  end

  it "can find a transaction by created_at" do
    created_at = create(:transaction, invoice_id: 1, created_at: "2012-03-27T14:54:09.000Z")
    id = created_at.id
    created_at = created_at.created_at
    get "/api/v1/transactions/find?created_at=#{created_at}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["id"]).to eq(id.to_s)
  end

  it "can find all transactions by id" do
    id = create(:transaction, invoice_id: 1).id

    get "/api/v1/transactions/find_all?id=#{id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"][0]["id"]).to eq(id.to_s)
  end

  it "can find all transactions by invoice_id" do
    transaction_1 = create(:transaction, invoice_id: 1)
    transaction_2 = create(:transaction, invoice_id: 1)
    transaction_3 = create(:transaction, invoice_id: 1)
    invoice_id = transaction_1.invoice_id

    get "/api/v1/transactions/find_all?invoice_id=#{invoice_id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["attributes"]["invoice_id"]).to eq(invoice_id)
    expect(transaction["data"][1]["attributes"]["invoice_id"]).to eq(invoice_id)
    expect(transaction["data"][2]["attributes"]["invoice_id"]).to eq(invoice_id)
  end

  it "can find all transactions by credit_card_expiration_date" do
    transaction_1 = create(:transaction, invoice_id: 1)
    transaction_2 = create(:transaction, invoice_id: 1, credit_card_expiration_date: "2019-01-22")
    transaction_3 = create(:transaction, invoice_id: 1, credit_card_expiration_date: "2019-01-22")
    credit_card_expiration_date = "2019-01-22"

    get "/api/v1/transactions/find_all?credit_card_expiration_date=#{credit_card_expiration_date}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["attributes"]["credit_card_expiration_date"]).to eq(credit_card_expiration_date)
    expect(transaction["data"][1]["attributes"]["credit_card_expiration_date"]).to eq(credit_card_expiration_date)
    expect(transaction["data"][2]["attributes"]["credit_card_expiration_date"]).to eq(credit_card_expiration_date)
  end

  it "can find all transactions by result" do
    transaction_1 = create(:transaction, invoice_id: 1)
    transaction_2 = create(:transaction, invoice_id: 1)
    transaction_3 = create(:transaction, invoice_id: 1)
    result = transaction_1.result
    get "/api/v1/transactions/find_all?result=#{result}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["attributes"]["result"]).to eq(result)
    expect(transaction["data"][1]["attributes"]["result"]).to eq(result)
    expect(transaction["data"][2]["attributes"]["result"]).to eq(result)
  end

  it "can find all transactions by credit_card_number" do
    transaction_1 = create(:transaction, invoice_id: 1)
    transaction_2 = create(:transaction, invoice_id: 1)
    transaction_3 = create(:transaction, invoice_id: 1)
    credit_card_number = transaction_1.credit_card_number

    get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["attributes"]["credit_card_number"]).to eq(credit_card_number)
    expect(transaction["data"][1]["attributes"]["credit_card_number"]).to eq(credit_card_number)
    expect(transaction["data"][2]["attributes"]["credit_card_number"]).to eq(credit_card_number)
  end

  it "can find all transactions by created_at" do
    transaction_1 = create(:transaction, invoice_id: 1, created_at: "2012-03-27T14:54:09.000Z")
    transaction_2 = create(:transaction, invoice_id: 1, created_at: "2012-03-27T14:54:09.000Z")
    transaction_3 = create(:transaction, invoice_id: 1, created_at: "2012-03-27T14:54:09.000Z")
    id = transaction_1.id
    id_2 = transaction_2.id
    id_3 = transaction_3.id
    created_at = transaction_1.created_at

    get "/api/v1/transactions/find_all?created_at=#{created_at}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["id"]).to eq(id.to_s)
    expect(transaction["data"][1]["id"]).to eq(id_2.to_s)
    expect(transaction["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "can find all transactions by updated_at" do
    transaction_1 = create(:transaction, invoice_id: 1, updated_at: "2012-03-27T14:54:09.000Z")
    transaction_2 = create(:transaction, invoice_id: 1, updated_at: "2012-03-27T14:54:09.000Z")
    transaction_3 = create(:transaction, invoice_id: 1, updated_at: "2012-03-27T14:54:09.000Z")
    id = transaction_1.id
    id_2 = transaction_2.id
    id_3 = transaction_3.id
    updated_at = transaction_1.updated_at

    get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"][0]["id"]).to eq(id.to_s)
    expect(transaction["data"][1]["id"]).to eq(id_2.to_s)
    expect(transaction["data"][2]["id"]).to eq(id_3.to_s)
  end

  it "returns a random transaction" do
    transaction = create(:transaction, invoice_id: 1)
    id = transaction.id

    get "/api/v1/transactions/random.json"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    allow(Transaction.all).to receive(:random).and_return(id)
  end

  it "returns a invoice associated with a transaction" do
    transaction = create(:transaction, invoice_id: 1)
    id = transaction.invoice_id
    get "/api/v1/transactions/#{transaction.id}/invoice"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction["data"]["relationships"]["invoice"]["data"]["id"]).to eq(id.to_s)
  end
end