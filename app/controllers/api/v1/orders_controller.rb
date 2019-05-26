class Api::V1::OrdersController < ApplicationController
  def index
    orders = OrderFacade.get_orders(get_business(request_body[:api_key]))
    render json: OrderSerializer.new(orders), status: 200
  end

  def create
    business = get_business(request_body[:api_key])
    order = Order.create!(total_cost: request_body[:total_cost],
                          total_revenue: request_body[:total_revenue],
                          business: business)
    order.create_order_items(request_body[:items], order.id)
    data = order.message(business, request_body[:items])
    @data = data
    # TwilioTextMessenger.new.send_order(data)
    RepresentativeNotifierMailer.send_order(data).deliver_now
    render json: {}, status: 201
  end

  private
  def request_body
    params.permit(:api_key, :total_cost, :total_revenue, items: [:id, :quantity, :price])
  end
end
