class Plot < ApplicationRecord
  belongs_to :garden

  validates_presence_of :name
  validates_uniqueness_of :name
end
