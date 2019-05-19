FactoryBot.define do
  factory :business_item do
    business { nil }
    item { nil }
    price_sold { 1.5 }
    quantity { 1 }
    serving_size { 1.5 }
  end
end
