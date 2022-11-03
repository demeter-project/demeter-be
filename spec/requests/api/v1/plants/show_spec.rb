require 'rails_helper'

RSpec.describe 'GET /plants/:id' do
  describe 'When the record exists' do
    it 'returns detailed information for the requested plant' do
      plant = create(:plant)

      get "/api/v1/plants/#{plant.id}"
      
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data]).to have_key(:type)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to have_key(:usda_symbol)
      expect(result[:data][:attributes][:usda_symbol]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:scientific_name)
      expect(result[:data][:attributes][:scientific_name]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:common_name)
      expect(result[:data][:attributes][:common_name]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:states)
      expect(result[:data][:attributes][:states]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:flower_color)
      expect(result[:data][:attributes][:flower_color]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:drought_tolerance)
      expect(result[:data][:attributes]).to have_key(:fire_tolerance)
      expect(result[:data][:attributes]).to have_key(:moisture_use)
      expect(result[:data][:attributes]).to have_key(:toxicity)
      expect(result[:data][:attributes]).to have_key(:duration)
      expect(result[:data][:attributes]).to have_key(:growth_rate)
      expect(result[:data][:attributes]).to have_key(:salinity_tolerance)
      expect(result[:data][:attributes]).to have_key(:shade_tolerance)
      expect(result[:data][:attributes]).to have_key(:edible)
      expect(result[:data][:attributes]).to have_key(:ph_maximum)
      expect(result[:data][:attributes]).to have_key(:ph_minimum)
      expect(result[:data][:attributes]).to have_key(:temperature_min)
      expect(result[:data][:attributes][:temperature_min]).to be_an(Integer)
      expect(result[:data][:attributes]).to have_key(:frost_free_days_min)
      expect(result[:data][:attributes][:frost_free_days_min]).to be_an(Integer)
      expect(result[:data][:attributes]).to have_key(:precipitation_max)
      expect(result[:data][:attributes][:precipitation_max]).to be_an(Integer)
      expect(result[:data][:attributes]).to have_key(:precipitation_min)
      expect(result[:data][:attributes][:precipitation_min]).to be_an(Integer)
    end
  end

  describe 'When the record does not exist' do
    it 'returns a status 404 response' do
      get "/api/v1/plants/1"

      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      get "/api/v1/plants/1"
      
      expect(response.body).to match(/Couldn't find Plant/)
    end
  end
  
end