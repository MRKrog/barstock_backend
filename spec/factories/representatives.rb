FactoryBot.define do
  factory :representative do
    distributor
    sequence(:name) { |n| "Rep #{n}" }
    sequence(:email) { |n| "rep_#{n}@gmail.com" }
    sequence(:phone_number) { |n| 1234+n }
  end
end
