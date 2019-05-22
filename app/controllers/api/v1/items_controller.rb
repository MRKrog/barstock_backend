class Api::V1::ItemsController < ApplicationController

  def index
    business = get_business(api_key_param[:api_key])
    items = Item.distributor_items(business.distributor_id)
    render json: ItemSerializer.new(items)
  end

  def create
    distributor = get_distributor(api_key_param[:api_key])
    Item.create!(name: item_params[:name],
                 alc_type: item_params[:alc_type],
                 alc_category: item_params[:alc_category],
                 price: item_params[:price],
                 quantity: item_params[:quantity],
                 ounces: item_params[:ounces],
                 unit: item_params[:unit],
                 thumbnail: item_params[:thumbnail],
                 distributor_id: distributor.id)
    render json: {}, status: 201
  end

  def update
    distributor = get_distributor(api_key_param[:api_key])
    item = Item.update(item_id_param[:id],
                       name: item_params[:name],
                       alc_type: item_params[:alc_type],
                       alc_category: item_params[:alc_category],
                       price: item_params[:price],
                       quantity: item_params[:quantity],
                       ounces: item_params[:ounces],
                       unit: item_params[:unit],
                       thumbnail: item_params[:thumbnail],
                       distributor_id: distributor.id)
    render json: ItemSerializer.new(item), status: 200
  end

  private
  def api_key_param
    params.permit(:api_key)
  end

  def item_params
    params.permit(:name, :alc_type, :alc_category, :price, :quantity, :ounces, :unit, :thumbnail)
  end

  def item_id_param
    params.permit(:id)
  end
end
