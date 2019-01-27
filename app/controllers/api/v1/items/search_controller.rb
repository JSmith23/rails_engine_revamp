class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(look_params))
  end

  def show
    render json: ItemSerializer.new(Item.find_by(look_params))
  end

  private

  def look_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end