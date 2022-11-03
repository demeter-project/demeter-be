Faker::Config.locale = 'en-US'

FactoryBot.define do
  factory :garden do
    name { Faker::Books::Dune.planet }
    zip_code { [
      '35004', '99501', '71601', '90001', '06001', '19701', '32003', '96701',
       '83201', '46001', '66002', '40003', '70001', '20588', '01001',
        '48001', '55001', '38601', '63001','59001', '68001', '59001', '73001'].sample }
    state_code { Faker::Address.state_abbr }
  end
end