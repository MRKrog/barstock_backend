class Api::V1::OrdersController < ApplicationController

  def create
    business = find_business(order_params[:api_key])
    order = Order.create!(total_cost: order_params[:total_cost], total_revenue: order_params[:total_revenue], business_id: business.id)
    count = 0
    order_params[:items].each do |item|
      OrderItem.create!(quantity: order_params[:items][count][:quantity], price: order_params[:items][count][:price], order_id: order.id, item_id: order_params[:items][count][:id].to_i, unit: 1)
      count += 1
    end
    render json: {}, status: 201
  end

  private
  def order_params
    params.permit(:api_key, :total_cost, :total_revenue, items: [:id, :quantity, :price])
  end
end
