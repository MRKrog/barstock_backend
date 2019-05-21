class BusinessItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :alc_type,
             :alc_category,
             :thumbnail,
             :price_sold,
             :serving_size,
             :quantity

end
