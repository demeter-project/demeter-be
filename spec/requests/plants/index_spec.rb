require 'rails_helper'

RSpec.describe '/api/v1/plants endpoints' do
  describe 'GET plants#index' do
    it 'returns a json response containing all plants native to queried state' do
      plants = create_list(:plant, 10, states: "VT CT VA WA")
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
      expect(actual_first[:attributes]).to have_key(:usda_symbol)
      expect(actual_first[:attributes]).to have_key(:scientific_name)
      expect(actual_first[:attributes]).to have_key(:common_name)
      expect(actual_first[:attributes]).to have_key(:states)
      expect(actual_first[:attributes]).to have_key(:flower_color)
      expect(actual_first[:attributes]).to have_key(:drought_tolerance)
      expect(actual_first[:attributes]).to have_key(:fire_tolerance)
      expect(actual_first[:attributes]).to have_key(:moisture_use)
      expect(actual_first[:attributes]).to have_key(:toxicity)
      expect(actual_first[:attributes]).to have_key(:duration)
      expect(actual_first[:attributes]).to have_key(:growth_rate)
      expect(actual_first[:attributes]).to have_key(:salinity_tolerance)
      expect(actual_first[:attributes]).to have_key(:shade_tolerance)
      expect(actual_first[:attributes]).to have_key(:edible)
      expect(actual_first[:attributes]).to have_key(:ph_minimum)
      expect(actual_first[:attributes]).to have_key(:ph_maximum)
      expect(actual_first[:attributes]).to have_key(:temperature_min)
      expect(actual_first[:attributes]).to have_key(:frost_free_days_min)
      expect(actual_first[:attributes]).to have_key(:precipitation_min)
      expect(actual_first[:attributes]).to have_key(:precipitation_max)
    end

    describe 'sad path: state missing or empty' do
      it 'returns an error' do
        get '/api/v1/plants?state='

        expect(response).not_to be_successful
        require 'pry'; binding.pry
      end
    end
  end
end