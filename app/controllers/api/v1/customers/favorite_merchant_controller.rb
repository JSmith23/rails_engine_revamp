class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.favorite_merchant(params[:id]))
  end
end