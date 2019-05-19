FactoryBot.define do
  factory :order_item do
    order { nil }
    item { nil }
    quantity { 1 }
    unit { "MyString" }
    price { 1.5 }
  end
end
