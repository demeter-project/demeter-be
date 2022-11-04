class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant
  validates_presence_of :plot_id, :plant_id

  def self.find_plot_plants(plot_id)
    where(plot_id: plot_id)
  end
end
