require 'rails_helper'

RSpec.describe WeatherFacade do
  it 'returns a 7 day forecast', :vcr do
    forecast = WeatherFacade.get_forecast('41.83','-87.68')

    expect(forecast).to be_an(Array)
    expect(forecast.first).to be_instance_of(Weather)
    expect(forecast.first.day).to be_a(String)
  end
end