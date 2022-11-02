class Api::V1::PlotsController < ApplicationController
  def index
    garden = Garden.find(params[:garden_id])
    
    plots = PlotSerializer.new(garden.plots)
    render json: plots
  end
end