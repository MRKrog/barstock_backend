class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :alc_type,
              :alc_category,
              :name,
              :price,
              :ounces,
              :unit,
              :thumbnail
end
