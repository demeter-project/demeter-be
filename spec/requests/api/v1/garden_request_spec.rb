require 'rails_helper'

RSpec.describe 'Garden API' do
  describe 'GET /gardens/:id' do
    it 'returns data for one garden', :vcr do
      garden = create(:garden)

      get "/api/v1/gardens/#{garden.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      garden = JSON.parse(response.body, symbolize_names: true)

      expect(garden).to be_a(Hash)
      expect(garden).to have_key(:data)
      expect(garden[:data]).to have_key(:id)
      expect(garden[:data]).to have_key(:type)
      expect(garden[:data]).to have_key(:attributes)
      expect(garden[:data][:attributes]).to have_key(:name)
      expect(garden[:data][:attributes][:name]).to be_a(String)
      expect(garden[:data][:attributes]).to have_key(:zip_code)

      expect(garden[:data][:attributes][:zip_code]).to be_a(String)
      expect(garden[:data][:attributes]).to have_key(:state_code)
      expect(garden[:data][:attributes][:state_code]).to be_a(String)
      expect(garden[:data][:attributes]).to have_key(:weather_forecast)
      expect(garden[:data][:attributes][:weather_forecast]).to be_an(Array)
      day = garden[:data][:attributes][:weather_forecast].first
      expect(day).to be_a(Hash)
      expect(day.count).to eq(13)
      expect(day).to have_key(:temperature)
    end
  end
end