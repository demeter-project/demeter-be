class HardinessService
  def self.conn
    Faraday.new(url: 'https://phzmapi.org')
  end

  def self.get_lat_lon(zipcode)
    response = conn.get("/#{zipcode}.json")
    JSON.parse(response.body, symbolize_names: true)
  end
end