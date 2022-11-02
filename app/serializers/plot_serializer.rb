class PlotSerializer
  include JSONAPI::Serializer

  attributes :name

  has_many :plants
end