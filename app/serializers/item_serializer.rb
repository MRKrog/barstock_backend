class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :alc_type,
              :alc_category,
              :name,
              :price,
              :quantity,
              :ounces,
              :unit,
              :thumbnail
end
