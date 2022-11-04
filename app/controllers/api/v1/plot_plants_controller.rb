class Api::V1::PlotPlantsController < ApplicationController
  def index
    plot_plant = PlotPlant.find_plot_plants(params[:plot_id])
    plot_plant.each do |pp|
      pp.update(date_planted: Time.now)
    end
    render json: PlotPlantSerializer.new(plot_plant)
  end
end