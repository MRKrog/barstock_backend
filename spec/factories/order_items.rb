FactoryBot.define do
  factory :order_item do
    order
    item
    sequence(:quantity) { |n| ("#{n}".to_i+1) }
    sequence(:unit) { |n| "Unit #{n}" }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
  end
end
