FactoryBot.define do
  factory :product do
    name { Faker::Device.model_name }
    description { Faker::Lorem.sentence(word_count: 3) }
    price { Faker::Number.decimal(l_digits: 2) }
    balance { Faker::Number.between(from: 1, to: 10) }
  end

  trait :invalid do
    name { nil }
    description { nil }
    price { -1 }
    balance { -999 }
  end
end
