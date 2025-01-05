FactoryBot.define do
  factory :situation do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
