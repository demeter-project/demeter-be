FactoryBot.define do
  factory :plant do
    usda_symbol { "ABBA" }
    scientific_name { Faker::Science.element }
    common_name { Faker::Science.element }
    states { "VT CA VA CT" }
    flower_color { Faker::Color.color_name }
    drought_tolerance { %w(Low Medium High).sample }
    fire_tolerance { %w(Low Medium High).sample }
    moisture_use { %w(Low Medium High).sample }
    toxicity { %w(None Slight Moderate Severe).sample }
    duration { %w(Annual Perennial Biannual).sample }
    growth_rate { %w(Slow Moderate Rapid).sample }
    salinity_tolerance { %w(None Low Medium High).sample }
    shade_tolerance { %w(Tolerant Intermediate Intolerant).sample }
    edible { Faker::Boolean.boolean }
    ph_minimum { Faker::Number.within(range: 3..6.5).round(1) }
    ph_maximum { Faker::Number.within(range: 6.5..9.9).round(1) }
    temperature_min { Faker::Number.between(from: -50, to: 65)}
    frost_free_days_min { Faker::Number.within(range: 70..200)}
    precipitation_min { Faker::Number.within(range: 2..20) }
    precipitation_max { Faker::Number.within(range: 20..150) }
  end
end