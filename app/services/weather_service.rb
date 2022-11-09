class WeatherService 
  def self.conn
    Faraday.new(url: 'https://api.weather.gov')
  end

  def self.get_forecast(latitude, longitude)
    Rails.cache.fetch("forecast-#{latitude}-#{longitude}", expires_in: 6.hours) do
      url = conn.get("/points/#{latitude},#{longitude}")
      return nil if url.status == 404
      url = conn.get(response.headers[:location]) if url.status == 301
      forecast_url = JSON.parse(url.body, symbolize_names: true)
      response = conn.get("#{forecast_url[:properties][:forecast]}")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end