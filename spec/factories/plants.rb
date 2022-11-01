FactoryBot.define do
  factory :plant do
    symbol { "ABBA" }
    scientific_name { Faker::Science.element }
    common_name { Faker::Science.element }
    temperature_min { Faker::Number.between(from: -50, to: 65)}
    moisture_use { Faker::Number.between(from: 0, to: 2) }
    native_states { "VT CA VA CT" }
  end
end