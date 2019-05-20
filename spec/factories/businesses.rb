FactoryBot.define do
  factory :business do
    distributor
    representative
    sequence(:name) { |n| "Business #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    sequence(:email) { |n| "business_#{n}@gmail.com" }
    sequence(:phone_number) { |n| 1234+n }
    password { "password" }
    sequence(:api_key) { SecureRandom.urlsafe_base64 }
  end
end
