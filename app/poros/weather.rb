class Weather
  attr_reader :day,
              :daytime,
              :temperature,
              :short_forecast,
              :detailed_forecast

  def initialize(data)
    @day = data[:name]
    @daytime = data[:isDaytime]
    @temperature = data[:temperature]
    @short_forecast = data[:shortForecast]
    @detailed_forecast = data[:detailedForecast]
  end
end