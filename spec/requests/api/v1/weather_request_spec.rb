require 'rails_helper'

RSpec.describe 'Weather API', :vcr do
  describe 'GET /weather?zipcode=x' do
    it 'returns a 7 day forecast for my given zipcode' do
      WeatherFacade.get_forecast('60647')

      get '/api/v1/weather?zipcode=60647'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data].count).to eq(14)
    end
  end
end