class Plant < ApplicationRecord
  enum moisture_use: { low: 0, medium: 1, high: 2 }

  validates_presence_of %i[
    symbol 
    scientific_name 
    common_name 
    temperature_min 
    moisture_use
    native_states]

  validates_numericality_of :temperature_min

  # belongs_to :plot

  def self.native_to(state)
    
  end
end
