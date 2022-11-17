class Weather
  attr_reader :period, :temp, :weather, :icon_path

  def initialize(weather_data)
    @period = Time.at(weather_data[:dt]).utc
    @temp = weather_data[:main][:temp]
    @weather = weather_data[:weather][0][:description].titleize
    @icon_path = "http://openweathermap.org/img/wn/#{weather_data[:weather][0][:icon]}.png"
  end

end