class CocktailSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :name,
              :ingredients,
              :recipe,
              :id

end
