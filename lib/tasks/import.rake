require 'csv'

namespace :import do
  desc "imports merchants from a csv file"
  task :merchant => :environment do
    CSV.foreach("lib/seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end


  desc "imports items from a csv file"
  task :item => :environment do
    CSV.foreach("lib/seeds/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
    end
  end


  desc "imports customers from a csv file"
  task :customer => :environment do
    CSV.foreach("lib/seeds/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  desc "imports invoices from a csv file"
  task :invoice => :environment do
    CSV.foreach("lib/seeds/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end


  desc "imports invoice_items from a csv file"
  task :invoice_item => :environment do
    CSV.foreach("lib/seeds/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  desc "imports transactions from a csv file"
  task :transaction => :environment do
    CSV.foreach("lib/seeds/transactions.csv", headers: true) do |row|
      # TODO: fill `credit_card_expiration_date` in csv instead of time now
      Transaction.create!(row.to_h.merge(credit_card_expiration_date: Time.now))
    end
  end

  task :all => [:customer, :merchant, :item, :invoice, :transaction, :invoice_item]
end



