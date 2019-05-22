class Api::V1::OrdersController < ApplicationController

  def create
    order = Order.create!(total_cost: order_params[:total_cost],
                          total_revenue: order_params[:total_revenue],
                          business: get_business(order_params[:api_key]))
    order.create_order_items(order_params[:items], order.id)
    render json: {}, status: 201
  end

  private
  def order_params
    params.permit(:api_key, :total_cost, :total_revenue, items: [:id, :quantity, :price])
  end
end
