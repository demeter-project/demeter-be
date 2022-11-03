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
    garden = Garden.create(garden_params)
    if garden.save
      render json: GardenSerializer.new(garden), status: 201
    else
      errors = ErrorSerializer.new(garden.errors)
      render json: errors.show, status: 400
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:user_id, :zip_code, :name, :state_code)
  end
end