class LocationService
  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |faraday|
      faraday.params['apiKey'] = ENV['location_api']
    end
  end

  def self.get_lat_lon(zip_code)
    Rails.cache.fetch("zip - #{zip_code}", expires_in: 30.days) do
      response = conn.get("/v1/geocode/search?postcode=#{zip_code}&filter=countrycode:us")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end