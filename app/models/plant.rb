class Plant < ApplicationRecord  
  has_many :plot_plants
  has_many :plots, through: :plot_plants
  
  def self.native_to(state)
    where('states like ?', "%#{state}%")
  end
end
