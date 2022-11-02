class Plant < ApplicationRecord
  
  validates_presence_of %i[
    usda_symbol 
    scientific_name 
    common_name 
    states
    moisture_use
    temperature_min
  ]

  validates_numericality_of :temperature_min
  
  belongs_to :plot
  
  def self.native_to(state)
    where('states like ?', "%#{state}%")
  end
end

# other attributes that may/may not have data: 

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