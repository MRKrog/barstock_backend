class Api::V1::OrdersController < ApplicationController
  def index
    business = get_business(request_body[:api_key])
    orders = Order.where(business_id: business.id)
    render json: OrderSerializer.new(orders), status: 200
  end

  def create
    order = Order.create!(total_cost: request_body[:total_cost],
                          total_revenue: request_body[:total_revenue],
                          business: get_business(request_body[:api_key]))
    order.create_order_items(request_body[:items], order.id)
    render json: {}, status: 201
  end

  private
  def request_body
    params.permit(:api_key, :total_cost, :total_revenue, items: [:id, :quantity, :price])
  end
end
