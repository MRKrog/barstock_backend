class Api::V1::CocktailsController < ApplicationController

  def show
    business = get_business(cocktail_params[:api_key])
    item = BusinessItem.find(cocktail_params[:id]).item
    cocktail = CocktailFacade.new(item.alc_category, item.id).get_cocktail
    render json: CocktailSerializer.new(cocktail)
  end

  private

  def cocktail_params
    params.permit(:api_key, :id)
  end


end
