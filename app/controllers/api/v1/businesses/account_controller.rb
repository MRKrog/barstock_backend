class Api::V1::Businesses::AccountController < ApplicationController

  def show
    bus = get_business(account_params[:api_key])
    bus_data = BusinessAccount.new(bus, bus.distributor, bus.representative)
    render json: { business: BusinessSerializer.new(bus_data) }
  end

  private

  def account_params
    params.permit(:api_key)
  end

end
