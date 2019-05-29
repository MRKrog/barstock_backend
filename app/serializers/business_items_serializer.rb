class BusinessItemsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :item_name,
             :alc_type,
             :alc_category,
             :thumbnail,
             :price_sold,
             :serving_size,
             :quantity,
             :item_id

end
