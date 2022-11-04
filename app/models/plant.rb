class Plant < ApplicationRecord  
  has_many :plot_plants
  has_many :plots, through: :plot_plants
  
  def self.native_to(state)
    where('states ilike ?', "%#{state}%")
  end

  def self.search_name(name, state)
    native_to(state).where('common_name ilike ? OR scientific_name ilike ?', "%#{name}%", "%#{name}%")
  end
end
