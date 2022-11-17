class WeatherService

  def self.get_forecast(zip_code)
    coord = get_coordinates(zip_code)
    response = conn.get("/data/2.5/forecast", lat: coord[:lat], lon: coord[:lon], units: 'imperial')
    forecast = JSON.parse(response.body, symbolize_names: true)
    forecast.has_key?(:list) ? forecast : nil
  end

  private

  def self.get_coordinates(zip_code)
    response = conn.get("/geo/1.0/zip", zip: "#{zip_code},US")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://api.openweathermap.org', params: { appid: ENV['open_weather_key'] })
  end
end