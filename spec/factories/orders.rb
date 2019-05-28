FactoryBot.define do
  factory :order do
    business
    total_cost { 100 }
  end
end
