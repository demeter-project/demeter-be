class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: :show
  before_action :set_index_vars, only: :index

  def index
    if @search_name.present? && !@search_name.blank?
      @plants = @plants.search_name(@search_name)
    elsif @sort_attribute.present? && !@sort_attribute.blank?
      @plants = @plants.sort_by_attr(@sort_attribute)
    end
    render json: PlantSerializer.new(@plants)
  end

  def show
    render json: PlantSerializer.new(@plant)
  end

  private

  def set_index_vars
    @state_code = params[:state_code]
    @zip_code = params[:zip_code]
    @search_name = params[:search_name]
    @sort_attribute = params[:sort_by]
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