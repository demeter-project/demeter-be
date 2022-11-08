class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: :show
  before_action :set_index_vars, only: :index

  def index
    if valid?(params[:search_name]) || valid?(params[:sort_by])
      @plants = search
    end
    render json: PlantSerializer.new(@plants, params: {hz_range_high: hz_range_high})
  end

  def show
    render json: PlantSerializer.new(@plant)
  end

  private

  def search
    @plants.search_name(params[:search_name]).sort_by_attr(params[:sort_by])
  end

  def set_index_vars
    @state_code = params[:state_code]
    @zip_code = params[:zip_code]
    if valid_params?
      @plants = Plant.native_to(@state_code)
    end
  end

  def valid_params?
    if valid?(@state_code) && valid?(@zip_code)
      true
    elsif valid?(@state_code) && !valid?(@zip_code)
      custom_error({zip_code: "must be present"})
      false
    elsif valid?(@zip_code) && !valid?(@state_code)
      custom_error({state_code: "must be present"})
      false
    else
      custom_error({state_code: "must be present", zip_code: "must be present"})
      false
    end
  end
  
  def hz_range_high
    PlantFacade.hz_range_high(@zip_code)
  end

  def custom_error(message_hash)
    error = ErrorSerializer.new(message_hash)
    render json: error.custom_show, status: 400
  end

  def valid?(param)
    param.present? && !param.blank?
  end

  def set_plant
    @plant = Plant.find(params[:id])
  end
end
