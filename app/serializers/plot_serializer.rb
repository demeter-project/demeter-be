class PlotSerializer
  include JSONAPI::Serializer

  attributes :name, :soil_ph_min, :soil_ph_max, :shade_tolerant

  has_many :plants
end