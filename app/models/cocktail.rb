class Cocktail
  attr_reader :name,
              :ingredients,
              :recipe,
              :id

  def initialize(data, id)
    @name = data[:name]
    @ingredients = data[:ingredients]
    @recipe = data[:recipe]
    @id = id
  end
end
