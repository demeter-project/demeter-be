require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Customers"
  task native_plants: :environment do
    native_plants = Rails.root.join("db", "data", "native_plants.csv")

    CSV.foreach(native_plants, headers: true, header_converters: :symbol) do |plant|
      plant_hash = {
        symbol: plant[:symbol],
        scientific_name: plant[:scientific_name],
        common_name: plant[:common_name],
        temperature_min: plant[:temperature_minimum_f],
        moisture_use: plant[:moisture_use]
      }

      if plant_hash.none? { |key, value| value.blank? || value.nil? || value == "NA" }
        Plant.create!(plant_hash)
      end
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('plants')
  end
end