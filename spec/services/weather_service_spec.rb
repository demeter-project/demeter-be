require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns an HTTP response of the 7 day forecast day and night for the given area', :vcr do
    forecast = WeatherService.get_forecast('41.83', '-87.68')
    expect(forecast).to be_a(Hash)
    expect(forecast[:properties]).to have_key(:periods)
    expect(forecast[:properties][:periods]).to be_an(Array)
    expect(forecast[:properties][:periods].count).to eq(14)

    weather_day_1 = forecast[:properties][:periods].first
    expect(weather_day_1).to have_key(:temperature)
    expect(weather_day_1[:temperature]).to be_an(Integer)
    expect(weather_day_1).to have_key(:icon)
    expect(weather_day_1[:icon]).to be_a(String)
  end

  it 'returns nil with a bad lat lon', :vcr do
    forecast = WeatherService.get_forecast('-4.6', '-58.2')

    expect(forecast).to be nil
  end
end