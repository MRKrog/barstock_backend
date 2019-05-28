class Api::V1::OrdersController < ApplicationController
  def index
    orders = OrderFacade.get_orders(get_business(request_body[:api_key]))
    render json: OrderSerializer.new(orders), status: 200
  end

  def create
    business = get_business(request_body[:api_key])
    order = Order.create!(total_cost: request_body[:total_cost],
                          business: business)
    order.create_order_items(request_body[:items], order.id)
    fire_senders(order, business)
    # render json: {created_at: order.created_at}, status: 201
    render json: OrderCreatedSerializer.new(order), status: 201
  end

  private
  def request_body
    params.permit(:api_key, :total_cost, items: [:id, :quantity, :price])
  end

  def fire_senders(order, business)
    message_data = order.message(business, request_body[:items])
    email_data = order.email(business, request_body[:items], request_body[:total_cost])
    TextSenderJob.perform_later(message_data)
    EmailSenderJob.perform_later(email_data)
  end
end
