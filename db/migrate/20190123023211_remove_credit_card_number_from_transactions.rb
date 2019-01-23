class RemoveCreditCardNumberFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :credit_card_number, :integer
  end
end
