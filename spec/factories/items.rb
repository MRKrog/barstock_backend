FactoryBot.define do
  factory :item do
    distributor { nil }
    name { "MyString" }
    alc_type { "MyString" }
    alc_category { "MyString" }
    price { 1.5 }
    ounces { 1.5 }
    unit { 1 }
    thumbnail { "MyString" }
    quantity { 1 }
  end
end
