class Api::V1::PlantsController < ApplicationController
  def index
    if valid_params?
      native_plants = PlantSerializer.new(Plant.native_to(params[:state]))
      render json: native_plants
    end
  end

  private

  def set_params
    @state = params[:state]
    @zip_code = params[:zip_code]
  end

  def valid_params?
    if !@state.present? || @state.blank?
      error = ErrorSerializer.new( {state: "must be present"} )
      render json: error.custom
      false
    elsif !@zip_code.present? || @zip_code.blank?
      error = ErrorSerializer.new( {zip_code: "must be present"} )
      render json: error.custom
      false
    end
  end
end