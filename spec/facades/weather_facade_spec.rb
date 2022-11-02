require 'rails_helper'

RSpec.describe WeatherFacade do
  it 'returns a 7 day forecast' do
    forecast = WeatherFacade.get_forecast('41.83','-87.68')

    expect(forecast).to be_a()
  end
end