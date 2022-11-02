class PlantSerializer
  include JSONAPI::Serializer

  attributes  :usda_symbol, 
              :scientific_name, 
              :common_name,
              :states,
              :flower_color,
              :drought_tolerance,
              :fire_tolerance,
              :moisture_use,
              :toxicity,
              :duration,
              :growth_rate,
              :salinity_tolerance,
              :shade_tolerance,
              :edible,
              :ph_minimum,
              :ph_maximum,
              :temperature_min, 
              :frost_free_days_min,
              :precipitation_min,
              :precipitation_max
end