class Api::V1::Merchants::MostItemsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.most_items(10))
  end
end