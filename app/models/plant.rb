class Plant < ApplicationRecord
  # enum moisture_use: { "Low": 1, "Medium": 2, "High": 3 }
  # enum drought_tolerance: { "Intolerant": 0, "Low": 1, "Medium": 2, "High": 3 }
  # enum fire_tolerance: { "Intolerant": 0, "Low": 1, "Medium": 2, "High": 3 }
  # enum toxicity: { "Nontoxic": 0, "Slight": 1, "Moderate": 2, "Severe": 3 }
  # enum duration: { "Annual": 0, "Perennial": 1, "Biennial": 2 }
  # enum growth_rate: { "Slow": 0, "Moderate": 1, "Rapid": 2 }
  # enum salinity_tolerance: { "Intolerant": 0, "Low": 1, "Medium": 2, "High": 3 }
  # enum shade_tolerance: { "Intolerant": 0, "Intermediate": 1, "Tolerant": 2 }

  validates_presence_of %i[
    usda_symbol 
    scientific_name 
    common_name 
    states
    moisture_use
    temperature_min
  ]
  # drought_tolerance
  # fire_tolerance
  # toxicity
  # duration
  # growth_rate
  # salinity_tolerance
  # shade_tolerance
  # ph_minimum
  # ph_maximum
  # frost_free_days_min
  # precipitation_min
  # precipitation_max
  # temperature_min 

  validates_numericality_of :temperature_min

  # belongs_to :plot

  def self.native_to(state)
    where('native_states like ?', "%#{state}%")
  end
end
