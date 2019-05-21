class Api::V1::OrdersController < ApplicationController
  # accepts_nested_attributes_for :items

  def create
    binding.pry
  end

  private
  def order_params
    params.permit(:api_key, :total_cost, :total_revenue, items: [:id, :quantity])
  end
end
