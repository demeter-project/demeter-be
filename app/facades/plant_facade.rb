class PlantFacade
  def self.hz_range_high(zip_code)
    phz_hash = HardinessService.get_hardiness_info(zip_code)
    return nil if phz_hash.nil?
    temp_range = phz_hash[:temperature_range]
    temp_range.split(' ').last.to_i
  end
end