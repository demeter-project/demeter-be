class PlotSerializer
  include JSONAPI::Serializer

  attributes  :name,
              :plants
end