FactoryBot.define do
  factory :order do
    business { nil }
    total_cost { 1.5 }
    total_revenue { 1.5 }
  end
end
