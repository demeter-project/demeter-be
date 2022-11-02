Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :garden do
    name { Faker::Books::Dune.planet }
    zip_code { Faker::Address.zip_code[0,5] }
    state_code { Faker::Address.state_abbr }
  end
end