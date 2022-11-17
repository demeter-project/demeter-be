require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns hash response of forecast', :vcr do
    forecast = WeatherService.get_forecast("49643")
    expect(forecast).to be_a Hash

    expect(forecast[:list]).to be_an Array
    forecast[:list].each do |forecast_period|
      expect(forecast_period[:dt]).to be_an Integer
      expect(forecast_period[:main][:temp]).to be_a Numeric
      expect(forecast_period[:weather][0][:description]).to be_a String
      expect(forecast_period[:weather][0][:icon]).to be_a String
    end
  end

  it 'returns nil with a bad zip', :vcr do
    forecast = WeatherService.get_forecast("99999")
    expect(forecast).to be nil
  end

  it 'returns nil if the API errors or doesnt work', :vcr do
    stub_const 'ENV', ENV.to_h.merge('open_weather_key' => 'thisisabadapikey')
    forecast = WeatherService.get_forecast("49643")

    expect(forecast).to be nil
  end
end