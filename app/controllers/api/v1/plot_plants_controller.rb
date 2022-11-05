class Api::V1::PlotPlantsController < ApplicationController
  def index
    plot = Plot.find(params[:plot_id])
    plot_plant = plot.plot_plants

    render json: PlotPlantSerializer.new(plot_plant)
  end

  def destroy
    render json: PlotPlant.destroy(params[:id]), status: 204
  end
end