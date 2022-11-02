FactoryBot.define do
  factory :plot do
    name { Faker::Books::Dune.unique.city }
  end
end