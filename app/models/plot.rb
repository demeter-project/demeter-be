class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants, dependent: :destroy
  has_many :plants, through: :plot_plants

  validates_presence_of :name

  # validates_uniqueness_of :name

  def soil_ph_min
    return nil if plants.empty?
    plants.order(ph_minimum: :desc).first.ph_minimum
  end

  def soil_ph_max
    return nil if plants.empty?
    plants.order(ph_maximum: :asc).first.ph_maximum
  end

  def shade_tolerant?
    return nil if plants.empty?
    plants.all? { |plant| plant.shade_tolerance == "Tolerant"}
  end

  def contains_toxic?
    return nil if plants.empty?
    plants.all? { |plant| plant.toxicity == "None" }
  end

end
