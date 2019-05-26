class CocktailFacade

  def initialize(ingredient, id)
    @ingredient = ingredient
    @id = id
  end

  def get_cocktail
    all_ingredients
    Cocktail.new(create_data, @id)
  end

  def create_data
    data = {}
    data[:name] = cocktail[:strDrink]
    data[:ingredients] = all_ingredients
    data[:recipe] = cocktail[:strInstructions]
    return data
  end

  def cocktail
    cocktail_service.find_cocktail(@ingredient)
  end

  def cocktail_service
    @cocktail_service ||= CocktailService.new
  end

  def all_ingredients
    all = cocktail.find_all do |k, v|
      k.to_s.include?('Ingredient') && v != ""
    end
    ingredients = all.map do |ingredient|
      ingredient[-1]
    end
    ingredients.join(", ")
  end

end
