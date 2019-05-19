FactoryBot.define do
  factory :item do
    distributor
    sequence(:name) { |n| "Item #{n}" }
    sequence(:alc_type) { |n| "Alc type #{n}" }
    sequence(:alc_category) { |n| "Alc category #{n}" }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
    sequence(:ounces) { |n| ("#{n}".to_i+1)*3.3 }
    sequence(:unit) { |n| "Unit #{n}" }
    sequence(:thumbnail) { "https://picsum.photos/id/755/200/200?grayscale" }
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
  end
end
