class Api::V1::BusinessItemsController < ApplicationController

  def index
    b_items = BusinessItem.get_items(get_business(bi_params[:api_key]))
    render json: BusinessItemSerializer.new(b_items)
  end

  private
  def bi_params
    params.permit(:api_key)
  end
end
