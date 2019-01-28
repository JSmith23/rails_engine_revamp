class Api::V1::Transactions::SearchController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.where(look_params))
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_by(look_params))
  end

  private

  def look_params
    params.permit(:id, :result, :credit_card_number, :credit_card_expiration_date, :invoice_id, :created_at, :updated_at)
  end

end