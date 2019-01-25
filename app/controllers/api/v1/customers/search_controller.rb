class Api::V1::Customers::SearchController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.where(look_params))
  end

  def show
    render json: CustomerSerializer.new(Customer.find_by(look_params))
  end

  private

  def look_params
    params.permit(:first_name, :last_name)
  end
end