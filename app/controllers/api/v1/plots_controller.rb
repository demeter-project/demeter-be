class Api::V1::PlotsController < ApplicationController
  before_action :set_garden, only: %i[index create]

  def index
    plots = PlotSerializer.new(@garden.plots)
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

  def create
    plot = @garden.plots.create(plot_params)
    if plot.save
      render json: PlotSerializer.new(plot), status: 201
    else
      errors = ErrorSerializer.new(plot.errors)
      render json: errors.show, status: 400
    end
  end

  private

  def set_plot
    Plot.find(params[:id])

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end

  def plot_params
    params.permit(:name)
  end
end
