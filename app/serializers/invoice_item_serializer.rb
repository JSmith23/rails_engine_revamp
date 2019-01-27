class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  belongs_to :invoice
  belongs_to :item
end
