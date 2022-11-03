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
    set_params
    if check(@state) && check(@zip_code)
      true
    elsif check(@state) && !check(@zip_code)
      error = ErrorSerializer.new( {zip_code: "must be present"} )
      render json: error.custom_show, status: 400
      false
    elsif check(@zip_code) && !check(@state)
      error = ErrorSerializer.new( {state: "must be present"} )
      render json: error.custom_show, status: 400
      false
    else
      error = ErrorSerializer.new( {state: "must be present", zip_code: "must be present"} )
      render json: error.custom_show, status: 400
      false
    end
  end

  def check(param)
    param.present? && !param.blank?
  end
end