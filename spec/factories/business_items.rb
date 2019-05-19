FactoryBot.define do
  factory :business_item do
    business
    item
    sequence(:price_sold) { |n| ("#{n}".to_i+1)*4.5 }
    sequence(:quantity) { |n| ("#{n}".to_i+1) }
    sequence(:serving_size) { |n| ("#{n}".to_i+1)*2 }
  end
end
