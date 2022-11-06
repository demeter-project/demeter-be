class Api::V1::GardensController < ApplicationController
  before_action :set_garden, only: %i(show destroy)
  
  def index
    gardens = Garden.where(user_id: params[:user_id])
    render json: GardenSerializer.new(gardens)
  end
  
  def show
    render json: GardenSerializer.new(@garden, params: {weather: true})
  end

  def create
    garden = Garden.new(garden_params)
    if garden.save
      render json: GardenSerializer.new(garden), status: 201
    else
      errors = ErrorSerializer.new(garden.errors)
      render json: errors.show, status: 400
    end
  end

  def destroy
    @garden.destroy
  end
  
  private

  def set_garden
    @garden = Garden.find(params[:id])
  end
  
  def garden_params
    params.permit(:user_id, :zip_code, :name, :state_code)
  end
end