class Api::V1::Businesses::ItemsPopularityController < ApplicationController

  def index
    business = get_business(items_params[:api_key])
    items = Item.item_popularity(items_params[:limit], items_params[:order])
    render json: ItemSerializer.new(items)
  end

  private

  def items_params
    params.permit(:api_key, :order, :limit)
  end
end
