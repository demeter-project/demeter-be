class Api::V1::GardensController < ApplicationController
  def index
    gardens = Garden.where(user_id: params[:user_id])
    render json: GardenSerializer.new(gardens)
  end
  
  def show
    garden = Garden.find(params[:id])
    render json: GardenSerializer.new(garden, params: {weather: true})
  end

  def create

  end
end