FactoryBot.define do
  factory :order_item do
    order
    item
    sequence(:quantity) { |n| ("#{n}".to_i+1) }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
  end
end
