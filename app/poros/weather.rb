class Weather
  attr_reader :id,
              :day,
              :start_time,
              :end_time,
              :day_time,
              :temperature,
              :temperature_unit,
              :temperature_trend,
              :wind_speed,
              :wind_direction,
              :icon,
              :short_forecast,
              :detailed_forecast

  def initialize(data)
    @id = data[:number]
    @day = data[:name]
    @start_time = data[:startTime]
    @end_time = data[:endTime]
    @day_time = data[:isDaytime]
    @temperature = data[:temperature]
    @temperature_unit = data[:temperatureUnit]
    @temperature_trend = data[:temperatureTrend]
    @wind_speed = data[:windSpeed]
    @wind_direction = data[:windDirection]
    @icon = data[:icon]
    @short_forecast = data[:shortForecast]
    @detailed_forecast = data[:detailedForecast]
  end
end