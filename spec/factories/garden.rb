Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :garden do
    user_id { Faker::Number.unique.between(from: 1, to: 999) }
    name { Faker::Books::Dune.planet }
    zip_code { "80223" }
    state_code { Faker::Address.state_abbr }
  end
end