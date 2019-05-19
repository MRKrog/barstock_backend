class Api::V1::ItemsController < ApplicationController

  def index
    business = find_business(look_up_params['api_key'])
    if business == false
      binding.pry
      unauthorized
    else
      items = Item.distributor_items(business.distributor_id)
      # We need to sort this by type somehow
      render json: ItemSerializer.new(items)
    end
  end

  private
  def look_up_params
    params.permit(:api_key)
  end
end
