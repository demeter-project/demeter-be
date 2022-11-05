class HardinessService
  def self.conn
    Faraday.new(url: 'https://phzmapi.org')
  end

  def self.get_hardiness_info(zip_code)
    response = conn.get("/#{zip_code}.json")
    return nil if response.body.include?("NoSuchKey")
    JSON.parse(response.body, symbolize_names: true)
  end
end