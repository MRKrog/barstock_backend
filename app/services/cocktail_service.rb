class CocktailService

  def find_cocktail(ingredient)
    cocktail_name = JSON.parse(response_1(ingredient).body, symbolize_names: true)[:drinks].sample[:strDrink]
    find_recipe(cocktail_name)
  end

  def find_recipe(cocktail_name)
    JSON.parse(response_2(cocktail_name).body, symbolize_names: true)[:drinks][0]
  end

  def response_1(ingredient)
    conn.get do |req|
      req.url '/api/json/v1/1/filter.php'
      req.params['i'] = ingredient
    end
  end

  def response_2(cocktail_name)
    conn.get do |req|
      req.url 'api/json/v1/1/search.php'
      req.params['s'] = cocktail_name
    end
  end

  def conn
    Faraday.new(url: 'https://www.thecocktaildb.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end


end
