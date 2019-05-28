class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :created_at,
              :total_cost,
              :items
end
