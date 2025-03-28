FactoryBot.define do
  factory :exposure_step do
    exposure { association :exposure }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    duration { rand(1..10) }
  end
end
