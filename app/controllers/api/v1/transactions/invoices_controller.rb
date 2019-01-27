class Api::V1::Transactions::InvoicesController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find_by(id: params[:id]))
  end
end
