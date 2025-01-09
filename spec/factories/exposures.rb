FactoryBot.define do
  factory :exposure do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    situation { association :situation }
    user { association :user }
  end
end
