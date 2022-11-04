class Api::V1::PlotPlantsController < ApplicationController
  def index
    plot_plant = PlotPlant.find_plot_plants(params[:plot_id])
    render json: PlotPlantSerializer.new(plot_plant)
  end

  def update
    plot_plant = PlotPlant.find(params[:id])
    plot_plant.update(plot_plant_params)
    render json: PlotPlantSerializer.new(plot_plant)
  end

  private

  def plot_plant_params
    params.require(:plot_plant).permit(:quantity, :date_planted)
  end
end