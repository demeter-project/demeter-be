class Api::V1::PlotsController < ApplicationController
  
  def index
    garden = Garden.find(params[:garden_id])
    plots = PlotSerializer.new(garden.plots)
    render json: plots
  end

  def show
    plot = PlotSerializer.new(set_plot)

    # seperate plot plants controller
    # plot_plants = PlotPlantSerializer.new(plot.plot_plants)
    
    render json: plot
  end

  def destroy
    plot = set_plot
    plot.destroy
  end

  private

  def set_plot
    Plot.find(params[:id])
  end
end
