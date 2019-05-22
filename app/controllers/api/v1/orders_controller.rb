class Api::V1::OrdersController < ApplicationController
  def index
    business = get_business(api_key_params[:api_key])
    orders = Order.find_by(business_id: business.id)
    render json: OrderSerializer.new(orders), status: 200
  end

  private
  def api_key_params
    params.permit(:api_key)
  end
end
