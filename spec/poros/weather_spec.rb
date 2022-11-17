require 'rails_helper'

RSpec.describe Weather do

  it 'exists and has attributes' do
    data = {dt: 1668643200, main: {temp: 30.25}, weather: [{description: "its cold", icon: "13n"}]}
    weather = Weather.new(data)
    expect(weather).to be_instance_of Weather
    expect(weather.period).to be_a Time
    expect(weather.temp).to eq(30.25)
    expect(weather.weather).to eq("Its Cold")
    expect(weather.icon_path).to eq("http://openweathermap.org/img/wn/13n.png")
  end
end