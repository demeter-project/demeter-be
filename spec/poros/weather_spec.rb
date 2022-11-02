require 'rails_helper'

RSpec.describe Weather do
  before :each do 
    @weather = Weather.new({
      number: 1,
      name: "Tonight",
      startTime: "2022-11-01T20:00:00-05:00",
      endTime: "2022-11-02T06:00:00-05:00",
      isDaytime: false,
      temperature: 46,
      temperatureUnit: "F",
      temperatureTrend: nil,
      windSpeed: "5 mph",
      windDirection: "SSW",
      icon: "https://api.weather.gov/icons/land/night/few?size=medium",
      shortForecast: "Mostly Clear",
      detailedForecast: "Mostly clear, with a low around 46. South southwest wind around 5 mph."})
  end

  it 'exists' do
    expect(@weather).to be_a(Weather)
  end

  it 'has attributes', :vcr do
    expect(@weather.id).to eq(1)
    expect(@weather.day).to eq("Tonight")
    expect(@weather.start_time).to eq("2022-11-01T20:00:00-05:00")
    expect(@weather.end_time).to eq("2022-11-02T06:00:00-05:00")
    expect(@weather.day_time).to eq(false) 
    expect(@weather.temperature).to eq(46)
    expect(@weather.temperature_unit).to eq('F')
    expect(@weather.temperature_trend).to eq(nil)
    expect(@weather.wind_speed).to eq('5 mph')
    expect(@weather.wind_direction).to eq('SSW')
    expect(@weather.icon).to eq('https://api.weather.gov/icons/land/night/few?size=medium')
    expect(@weather.short_forecast).to eq('Mostly Clear')
    expect(@weather.detailed_forecast).to eq("Mostly clear, with a low around 46. South southwest wind around 5 mph.")
  end
end