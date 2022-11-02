class WeatherSerializer
  include JSONAPI::Serializer
  attributes :id, :day, :start_time, :end_time, :day_time, :temperature, :temperature_unit, :temperature_trend, :wind_speed, :wind_direction, :icon, :short_forecast, :detailed_forecast

end
