class PlantSerializer
  include JSONAPI::Serializer

  attributes  :symbol, 
              :scientific_name, 
              :common_name, 
              :temperature_min, 
              :moisture_use, 
              :native_states
end