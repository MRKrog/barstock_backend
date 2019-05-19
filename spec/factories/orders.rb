FactoryBot.define do
  factory :order do
    business
    total_cost { 100 }
    total_revenue { 25 }
  end
end
