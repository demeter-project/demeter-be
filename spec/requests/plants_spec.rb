require 'rails_helper'

RSpec.describe '/api/v1/plants endpoints' do
  describe 'GET plants#index' do
    it 'returns a json response containing all plants native to queried state' do
      plants = create_list(:plant, 10, native_states: "VT CT VA WA")
      get '/api/v1/plants?state=VT'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data].count).to eq(10)
      expected_first = plants.first
      actual_first = result[:data].first
      expect(actual_first).to have_key(:id)
      expect(actual_first[:id]).to eq(expected_first.id.to_s)
      expect(actual_first).to have_key(:attributes)
      expect(actual_first[:attributes]).to have_key(:symbol)
      expect(actual_first[:attributes]).to have_key(:scientific_name)
      expect(actual_first[:attributes]).to have_key(:common_name)
      expect(actual_first[:attributes]).to have_key(:temperature_min)
      expect(actual_first[:attributes]).to have_key(:moisture_use)
      expect(actual_first[:attributes]).to have_key(:native_states)
      require 'pry'; binding.pry
    end
  end
end