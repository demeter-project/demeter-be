require 'rails_helper'

RSpec.describe WeatherFacade do
  it 'returns a 7 day forecast', :vcr do
    forecast = WeatherFacade.forecast('60647')

    expect(forecast).to be_an(Array)
    expect(forecast.first).to be_instance_of(Weather)
    expect(forecast.first.period).to be_instance_of(Time)
  end

  it 'returns nil with bad zipcode', :vcr do
    forecast = WeatherFacade.forecast('99998')

    expect(forecast).to be nil
  end
end