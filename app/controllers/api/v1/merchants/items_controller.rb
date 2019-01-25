class Api::V1::Merchants::ItemsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_by(id: params[:id]))
  end
end
