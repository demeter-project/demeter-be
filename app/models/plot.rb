class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plants, through: :plot_plants

  validates_presence_of :name
  validates_uniqueness_of :name

  def soil_ph_min
    average(:ph_minimum)
  end

  def soil_ph_max
    average(:ph_maximum)
  end

  def average(attribute)
    if plants.empty?
      nil
    else
      plants.sum { |plant| plant.send(attribute) } / plants.count
    end
  end

  def shade_tolerant
    if plants.empty?
      nil
    else
      plants.all? { |plant| plant.shade_tolerance == "Tolerant"}
    end
  end
end
