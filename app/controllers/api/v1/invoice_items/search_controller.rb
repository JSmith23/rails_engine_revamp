class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(look_params))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(look_params))
  end

  private

  def look_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end