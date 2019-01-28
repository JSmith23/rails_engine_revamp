class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end
end