class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :total_cost,
              :items
end
