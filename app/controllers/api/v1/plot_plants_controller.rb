class Api::V1::PlotPlantsController < ApplicationController
  def index
    plot = Plot.find(params[:plot_id])
    plot_plant = plot.plot_plants

    render json: PlotPlantSerializer.new(plot_plant)
  end

  def update
    plot_plant = PlotPlant.find(params[:id])
    plot_plant.update(plot_plant_params)
    render json: PlotPlantSerializer.new(plot_plant)
  end
  
  def destroy
    PlotPlant.destroy(params[:id])
  end
  
  private

  def plot_plant_params
    params.permit(:quantity, :date_planted)
  end
 
end
