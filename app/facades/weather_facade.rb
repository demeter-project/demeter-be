class WeatherFacade

  def self.get_forecast(zipcode)
    lat_long = HardinessService.get_lat_lon(zipcode)[:coordinates]
    latitude = lat_long[:lat]
    longitude = lat_long[:lon]
    forecast = WeatherService.get_forecast(latitude, longitude)
    forecast[:properties][:periods].map do |day|
      Weather.new(day)
    end
  end
end