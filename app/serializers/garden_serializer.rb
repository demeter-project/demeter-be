class GardenSerializer
  include JSONAPI::Serializer
  attributes :name, :zip_code, :state_code, :user_id
  has_many :plots

  attribute :weather_forecast do |object, params|
    if params[:weather].present? && params[:weather]
      WeatherFacade.forecast(object.zip_code)
    end
  end
end
