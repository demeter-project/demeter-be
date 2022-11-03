class GardenSerializer
  include JSONAPI::Serializer
  attributes :name, :zip_code, :state_code, :weather_forecast
  has_many :plots

  attribute :weather_forecast do |object|
    WeatherFacade.get_forecast(object.zip_code)
  end
end
