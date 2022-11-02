class Api::V1::PlantsController < ApplicationController
  def index
    native_plants = PlantSerializer.new(Plant.native_to(params[:state]))
    render json: native_plants
  end
end