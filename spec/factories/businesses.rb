FactoryBot.define do
  factory :business do
    distributor { nil }
    name { "MyString" }
    address { "MyText" }
    email { "MyString" }
    phone_number { 1 }
    password_digest { "MyString" }
    api_key { "MyText" }
  end
end
