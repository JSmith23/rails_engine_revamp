class Api::V1::Items::MerchantsController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
end