require 'rails_helper'

RSpec.describe LocationService do
  it 'returns an HTTP response of location data for the zipcode provided', :vcr do
    location = LocationService.get_lat_lon('60647')

    expect(location).to be_a(Hash)
    expect(location[:features][0]).to have_key(:properties)
    expect(location[:features][0][:properties]).to be_a(Hash)
    expect(location[:features][0][:properties]).to have_key(:lon)
    expect(location[:features][0][:properties][:lon]).to be_a(Float)
    expect(location[:features][0][:properties]).to have_key(:lat)
    expect(location[:features][0][:properties][:lat]).to be_a(Float)
  end
end