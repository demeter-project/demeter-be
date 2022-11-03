class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: [:show]
  def index
    if valid_params?
      native_plants = PlantSerializer.new(Plant.native_to(params[:state]))
      render json: native_plants
    end
  end

  def show
    render json: PlantSerializer.new(@plant)
  end

  private

  def set_params
    @state_code = params[:state_code]
    @zip_code = params[:zip_code]
  end

  def valid_params?
    set_params
    if check(@state_code) && check(@zip_code)
      true
    elsif check(@state_code) && !check(@zip_code)
      error = ErrorSerializer.new( {zip_code: "must be present"} )
      render json: error.custom_show, status: 400
      false
    elsif check(@zip_code) && !check(@state_code)
      error = ErrorSerializer.new( {state_code: "must be present"} )
      render json: error.custom_show, status: 400
      false
    else
      error = ErrorSerializer.new( {state_code: "must be present", zip_code: "must be present"} )
      render json: error.custom_show, status: 400
      false
    end
  end

  def check(param)
    param.present? && !param.blank?
  end

  def set_plant
    @plant = Plant.find(params[:id])
  end

end