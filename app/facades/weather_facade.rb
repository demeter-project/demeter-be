class WeatherFacade
  def self.get_forecast(zip_code)
    response = LocationService.get_lat_lon(zip_code)
    if response[:features].empty?
      return nil
    else
      lat_lon = response[:features][0][:properties]
      latitude = lat_lon[:lat].round(2)
      longitude = lat_lon[:lon].round(2)
      forecast = WeatherService.get_forecast(latitude, longitude)
      forecast[:properties][:periods].map do |day|
        Weather.new(day)
      end
    end
  end
end