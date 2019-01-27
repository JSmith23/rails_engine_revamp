class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Item.random)
  end
end