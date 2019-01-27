class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end
end