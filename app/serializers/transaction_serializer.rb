class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :credit_card_expiration_date, :result, :created_at, :updated_at, :credit_card_number
  belongs_to :invoice
end
