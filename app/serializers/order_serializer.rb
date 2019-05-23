class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :total_cost,
              :total_revenue,
              :items
end
