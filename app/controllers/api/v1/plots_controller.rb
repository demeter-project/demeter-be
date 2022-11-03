class Api::V1::PlotsController < ApplicationController
  before_action :set_garden, only: %i[index create]
  before_action :set_plot, only: %i[show update destroy]

  def index
    plots = PlotSerializer.new(@garden.plots)
    render json: plots
  end

  def show
    render json: PlotSerializer.new(@plot)
  end

  def update
    if @plot.update(plot_params)
      render json: PlotSerializer.new(@plot)
    else
      errors = ErrorSerializer.new(@plot.errors)
      render rson: errors.show, status: 400
    end
  end

  def destroy
    @plot.destroy
  end

  def create
    plot = @garden.plots.new(plot_params)
    if plot.save
      render json: PlotSerializer.new(plot), status: 201
    else
      errors = ErrorSerializer.new(plot.errors)
      render json: errors.show, status: 400
    end
  end

  private

  def set_plot
    @plot = Plot.find(params[:id])
  end

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end

  def plot_params
    params.require(:plot).permit(:name, plant_ids: [])
  end
end
