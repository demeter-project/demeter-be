class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: [:show]
  before_action :set_params

  def index
    if valid_params?
      native_plants = Plant.native_to(params[:state_code])
      if @search_name.present? && !@search_name.blank?
        native_plants = native_plants.search_name(@search_name, @state_code)
      end
      render json: PlantSerializer.new(native_plants)
    end
  end

  def show
    render json: PlantSerializer.new(@plant)
  end

  private

  def set_params
    @state_code = params[:state_code]
    @zip_code = params[:zip_code]
    @search_name = params[:search_name]
  end

  def valid_params?
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