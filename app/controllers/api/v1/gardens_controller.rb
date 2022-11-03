class Api::V1::GardensController < ApplicationController
  def show
    garden = Garden.find(params[:id])
    render json: GardenSerializer.new(garden)
  end
end