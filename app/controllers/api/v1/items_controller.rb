class Api::V1::ItemsController < ApplicationController

  def index
    business = Business.find_by!(api_key: look_up_params[:api_key])
    items = Item.distributor_items(business.distributor_id)
    render json: ItemSerializer.new(items)
  end

  private
  def look_up_params
    params.permit(:api_key)
  end
end
