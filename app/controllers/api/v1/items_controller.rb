class Api::V1::ItemsController < ApplicationController

  def index
    business = get_business(api_key_params[:api_key])
    items = Item.distributor_items(business.distributor_id)
    render json: ItemSerializer.new(items)
  end

  def create
    distributor = get_distributor(api_key_params[:api_key])
    Item.create!(name: item_params[:name], alc_type: item_params[:alc_type], alc_category: item_params[:alc_category], price: item_params[:price], quantity: item_params[:quantity], ounces: item_params[:ounces], unit: item_params[:unit], thumbnail: item_params[:thumbnail], distributor_id: distributor.id)
    render json: {}, status: 201
  end

  private
  def api_key_params
    params.permit(:api_key)
  end

  def item_params
    params.permit(:name, :alc_type, :alc_category, :price, :quantity, :ounces, :unit, :thumbnail)
  end
end
