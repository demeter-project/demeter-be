require 'csv'

namespace :csv_load do
  desc "Read CSV File Customers"
  task native_plants: :environment do
    native_plants = Rails.root.join("db", "data", "native_plants.csv")

    CSV.foreach(native_plants, headers: true, header_converters: :symbol) do |plant|

      plant_hash = {
        usda_symbol: plant[:symbol],
        scientific_name: plant[:scientific_name],
        common_name: plant[:common_name],
        states: states_string(plant[:state_and_province]),
        temperature_min: plant[:temperature_minimum_f],
        flower_color: plant[:flower_color],
        frost_free_days_min: plant[:frost_free_days_minimum],
        ph_minimum: plant[:ph_minimum],
        ph_maximum: plant[:ph_maximum],
        precipitation_min: plant[:precipitation_minimum],
        precipitation_max: plant[:precipitation_maximum],
        drought_tolerance: plant[:drought_tolerance],
        fire_tolerance: plant[:fire_tolerance],
        moisture_use: plant[:moisture_use],
        toxicity: plant[:toxicity],
        duration: plant[:duration],
        growth_rate: plant[:growth_rate],
        salinity_tolerance: plant[:salinity_tolerance],
        shade_tolerance: plant[:shade_tolerance],
        edible: return_edible(plant[:palatable_human])
      }

      required_attrs = [
        plant_hash[:scientific_name],
        plant_hash[:common_name],
        plant_hash[:states],
        plant_hash[:temperature_min],
        plant_hash[:moisture_use]
      ]

      if required_attrs.none? { |attr| attr.nil? }
        Plant.create!(plant_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('plants')
  end

  def states_string(states)
    if !states.nil?
      states[/\(.*?\)/].gsub(/\W+/, " ").strip
    else
      states
    end
  end
  
  def return_edible(edible)
    if edible == "Yes"
      true
    else
      false
    end
  end
  
  # def growth_enum(growth_rate)
  #   case growth_rate
  #   when "Slow"
  #     0
  #   when "Moderate"
  #     1
  #   when "Rapid"
  #     2
  #   else
  #     1
  #   end
  # end


  # def return_enum(value)
  #   case value
  #   when "None" || "Intolerant" || "Annual"
  #     0
  #   when "Low" || "Slight" || "Intermediate" || "Perennial"
  #     1
  #   when "Medium" || "Moderate" || "Tolerant" || "Biannual"
  #     2
  #   when "High" || "Severe"
  #     3
  #   else
  #     2
  #   end
  # end
end