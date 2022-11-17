class WeatherFacade
  def self.forecast(zip_code)
    forecast_data = WeatherService.get_forecast(zip_code)
    return nil if !forecast_data
    weather = forecast_data[:list][0..20].map { |weather_period| Weather.new(weather_period) }
    weather.select.with_index{ |weather, i| i % 2 == 0 }
  end
end