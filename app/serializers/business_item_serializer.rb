class BusinessItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :price_sold,
             :serving_size,
             :quantity

end
