FactoryBot.define do
  factory :plot do
    name { Faker::Name.unique.name }
    plants { [] }
  end
end