class Plant < ApplicationRecord
  validates_presence_of %i[
    symbol 
    scientific_name 
    common_name 
    temperature_min 
    moisture_use]
  validates_numericality_of :temperature_min
end
