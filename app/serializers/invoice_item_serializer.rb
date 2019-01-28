class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity
  attribute :unit_price do |object|
    (object.unit_price / 100.00).to_s
  end
  belongs_to :invoice
  belongs_to :item
end
