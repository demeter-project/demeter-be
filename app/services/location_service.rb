class LocationService
  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |faraday|
      faraday.params['apiKey'] = ENV['location-api']
    end
  end

  def self.get_lat_lon(zipcode)
    response = conn.get("/v1/geocode/search?postcode=#{zipcode}")
    JSON.parse(response.body, symbolize_names: true)
  end
end