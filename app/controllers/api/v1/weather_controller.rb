class Api::V1::WeatherController < ApplicationController
  def index
    forecast = WeatherFacade.get_forecast(params[:zipcode])
    render json: WeatherSerializer.new(forecast)
  end
end