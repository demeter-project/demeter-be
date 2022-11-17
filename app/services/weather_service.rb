# class WeatherService 
#   def self.conn
#     Faraday.new(url: 'https://api.weather.gov')
#   end

#   def self.get_forecast(latitude, longitude)
#     # Rails.cache.fetch("forecast-#{latitude}-#{longitude}", expires_in: 6.hours) do
#       url = conn.get("/points/#{latitude},#{longitude}")
#       url = conn.get(url.headers[:location]) if url.status == 301
#       return nil if url.status == 404
#       forecast_url = JSON.parse(url.body, symbolize_names: true)
#       response = conn.get("#{forecast_url[:properties][:forecast]}")
#       JSON.parse(response.body, symbolize_names: true)
#     # end
#   end
# end

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