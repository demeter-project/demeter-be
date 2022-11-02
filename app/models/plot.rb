class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants, dependent: :destroy
  has_many :plants, through: :plot_plants

  validates_presence_of :name
  validates_uniqueness_of :name
end
