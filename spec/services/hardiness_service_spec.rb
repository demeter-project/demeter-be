require 'rails_helper'

RSpec.describe HardinessService do
  it 'returns an HTTP response of temp range for a given location', :vcr do
    response = HardinessService.get_lat_lon('60647')

    expect(response).to be_a(Hash)
    expect(response[:coordinates]).to have_key(:lat)
    expect(response[:coordinates]).to have_key(:lon)
    expect(response[:coordinates][:lat]).to be_an(Float)
    expect(response).to have_key(:temperature_range)
    expect(response[:temperature_range]).to be_a(String)
  end
end