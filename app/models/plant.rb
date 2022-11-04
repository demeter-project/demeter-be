class Plant < ApplicationRecord  
  has_many :plot_plants
  has_many :plots, through: :plot_plants
  
  def self.native_to(state_code)
    where('states ilike ?', "%#{state_code}%")
  end

  def self.search_name(name, state_code)
    native_to(state_code).where('common_name ilike ? OR scientific_name ilike ?', "%#{name}%", "%#{name}%")
  end
end
