class Api::V1::BusinessItemsController < ApplicationController

  def index
    b_items = BusinessItem.get_items(get_business(bi_params[:api_key]))
    render json: BusinessItemSerializer.new(b_items)
  end

  def create
    bi = BusinessItem.create_new(bi_params, get_business(bi_params[:api_key]))
    bi.save!
    render json: {}, status: 201
  end

  private
  def bi_params
    params.permit(:api_key, :price_sold, :quantity, :serving_size, :item_id)
  end
end
