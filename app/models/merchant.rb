class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.total_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

   def self.revenue(id)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .where(id: id)
    .first
  end

   def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total_sold desc')
    .limit(quantity)
  end
end

# returns the top x merchants ranked by total revenue