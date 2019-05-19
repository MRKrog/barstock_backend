class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
            :name,
            :price,
            :ounces,
            :unit,
            :thumbnail

end
