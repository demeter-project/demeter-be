FactoryBot.define do
  factory :plot do
    name { Faker::Books::Dune.unique.city }
    plants { [] }
  end
end