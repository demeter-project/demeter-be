class Api::V1::GardensController < ApplicationController
  before_action :set_garden, only: %i(show destroy)
  
  def index
    gardens = Garden.where(user_id: params[:user_id])
    render json: GardenSerializer.new(gardens)
  end
  
  def show
    render json: GardenSerializer.new(@garden, params: {weather: true})
  end

  def destroy
    @garden.destroy
  end

  private

  def set_garden
    @garden = Garden.find(params[:id])
  end
end