class WeatherFacade
  def self.get_forecast(latitude, longitude)
    forecast = WeatherService.get_forecast(latitude, longitude)
    require 'pry' ; binding.pry
    forecast[:properties][:periods].map do |day|
      
    end
  end
end