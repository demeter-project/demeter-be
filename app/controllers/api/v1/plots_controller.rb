class Api::V1::PlotsController < ApplicationController
  
  def index
    garden = Garden.find(params[:garden_id])
    plots = PlotSerializer.new(garden.plots)
    render json: plots
  end

  def show
    plot = PlotSerializer.new(Plot.find(params[:id]))

    # seperate plot plants controller
    # plot_plants = PlotPlantSerializer.new(plot.plot_plants)
    
    render json: plot
  end
end
