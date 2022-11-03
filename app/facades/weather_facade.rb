class WeatherFacade
  def self.get_forecast(zipcode)
    lat_long = LocationService.get_lat_lon(zipcode)[:features][0][:properties]
    latitude = lat_long[:lat].round(2)
    longitude = lat_long[:lon].round(2)
    forecast = WeatherService.get_forecast(latitude, longitude)
    forecast[:properties][:periods].map do |day|
      Weather.new(day)
    end
  end
end