class PlotPlantSerializer
  include JSONAPI::Serializer
  attributes :quantity, :date_planted

  attribute :plant_name do |object|
    object.plant.common_name
  end

  attribute :plant_id do |object|
    object.plant_id.to_s
  end

  attribute :date_planted do |object|
    object.date_planted.strftime("%Y/%m/%d")
  end
end