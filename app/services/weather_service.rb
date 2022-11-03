class WeatherService 
  def self.conn
    Faraday.new(url: 'https://api.weather.gov')
  end

  def self.get_forecast(latitude, longitude)
    url = conn.get("/points/#{latitude},#{longitude}")
    forecast_url = JSON.parse(url.body, symbolize_names: true)

    response = conn.get("#{forecast_url[:properties][:forecast]}")
    JSON.parse(response.body, symbolize_names: true)
  end
end