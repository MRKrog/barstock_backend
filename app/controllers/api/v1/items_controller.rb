class Api::V1::ItemsController < ApplicationController

  def index
    business = get_business(items_params[:api_key])
    items = Item.distributor_items(business.distributor_id)
    render json: ItemSerializer.new(items)
  end

  private
  def items_params
    params.permit(:api_key)
  end
end
