class Api::V1::BusinessItemsController < ApplicationController

  def index
    b_items = BusinessItem.get_items(get_business(api_key_params[:api_key]))
    render json: BusinessItemsSerializer.new(b_items)
  end

  def create
    bi = BusinessItem.create_new(bi_params, get_business(api_key_params[:api_key]))
    bi.save!
    render json: {}, status: 201
  end

  def update
    business = get_business(api_key_params[:api_key])
    bi = BusinessItem.update(bi_params[:id],
                             bi_params)
    render json: BusinessItemSerializer.new(bi)
  end

  private
  def bi_params
    params.permit(:price_sold, :quantity, :serving_size, :item_id, :id)
  end

  def api_key_params
    params.permit(:api_key)
  end
end
