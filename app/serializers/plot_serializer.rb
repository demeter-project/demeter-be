class PlotSerializer
  include JSONAPI::Serializer

  attributes  :name, 
              :soil_ph_min, 
              :soil_ph_max, 
              :shade_tolerant?, 
              :contains_toxic?

  has_many :plants
end